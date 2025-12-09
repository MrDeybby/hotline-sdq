event_inherited();

current_target = noone;

// Configuración IA
is_bot = true;

// Crear cerebro
neural_network = instance_create_layer(x, y, "Instances", obj_neural_network); 

// Configurar capas (Input: 8, Hidden: 12, 8, Output: 6)
neural_network.init_network([8, 8, 6]); 

// Variables Fitness
fitness = 0;
time_alive = 0;
damage_dealt = 0; 
shots_fired = 0;
shots_hit = 0;

level_completed = false;

start_x = x;
start_y = y;

// Debug visual
last_inputs = array_create(8, 0);
last_outputs = array_create(6, 0);

alarm[4] = 1

state = "idle"

// Sensores entorno
function get_sensors() {
    var _inputs = array_create(8, 0); 
    var _vision_radius = 400; 
    
    // --- 1. BUSCAR OBJETIVO UNIVERSAL ---
    // En lugar de instance_nearest(obj_Human), hacemos una búsqueda manual
    // para encontrar al obj_Player más cercano que NO SEA YO MISMO.
    
    current_target = noone;
    var _min_dist = 999999;
    
    // "other" dentro del with se refiere al Bot. "id" se refiere al candidato.
    with (obj_Player) {
        if (id != other.id && hp > 0) { // Si no soy yo y estoy vivo
            var _d = point_distance(x, y, other.x, other.y);
            if (_d < _min_dist) {
                _min_dist = _d;
                other.current_target = id; // ¡Encontrado!
            }
        }
    }
    
    var _target = current_target; // Usamos este para los cálculos
    var _potion = instance_nearest(x, y, obj_potion);
    
    // --- 2. SALUD Y ESCUDO ---
    _inputs[0] = hp / max_hp; 
    _inputs[1] = shield_ / max_shield;
    
    // --- 3. DATOS DEL OBJETIVO ---
    if (instance_exists(_target)) {
        var _dist = point_distance(x, y, _target.x, _target.y);
        var _dir = point_direction(x, y, _target.x, _target.y);
        var _angle = angle_difference(image_angle, _dir) / 180; // Ángulo
		
		_inputs[3] = _angle
		
        if (_dist <= _vision_radius) {
            _inputs[2] = _dist / _vision_radius; // Distancia
                   
            var _wall = collision_line(x, y, _target.x, _target.y, obj_wall, false, true);
            _inputs[4] = (_wall == noone) ? 1.0 : 0.0; // Visión
        } else {
            // Fuera de rango
            _inputs[2] = 1.0;
			_inputs[4] = 0.0; 
        }
    } else {
        // No hay nadie vivo en la sala
        _inputs[2] = -1.0; _inputs[3] = -1.0; _inputs[4] = 0.0; // Le damos -1 para que no confunda "fuera de rango" con "No hay nadie"
    }
    
    // --- 4. RECURSOS (Pócima) ---
    if (instance_exists(_potion)) {
        var _dist_p = point_distance(x, y, _potion.x, _potion.y);
        if (_dist_p <= _vision_radius) {
            _inputs[5] = _dist_p / _vision_radius;
            var _dir_p = point_direction(x, y, _potion.x, _potion.y);
            _inputs[6] = angle_difference(image_angle, _dir_p) / 180;
        } else {
            _inputs[5] = 1.0; _inputs[6] = 0.0;
        }
    } else {
        _inputs[5] = 1.0; _inputs[6] = 0.0;
    }
    
    // --- 5. PELIGRO ---
    var _bullet = instance_nearest(x, y, obj_projectile);
    var _danger = 0.0;
    if (instance_exists(_bullet)) {
        // Detectar balas que NO sean mías
        if (_bullet.owner != id && point_distance(x, y, _bullet.x, _bullet.y) < 80) {
            _danger = 1.0;
        }
    }
    _inputs[7] = _danger;
    
    return _inputs;
}