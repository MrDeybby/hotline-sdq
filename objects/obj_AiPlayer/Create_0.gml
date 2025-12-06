// Inherit the parent event
event_inherited();

current_target = noone;

// Configuración IA
is_bot = true;
// Crear cerebro
neural_network = instance_create_layer(x, y, "Instances", obj_neural_network); 

// Configurar capas
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


state = botState.WANDER
vision_radius = 400

// Sensores entorno
function get_sensors() {
	
    var _inputs = array_create(8, 0); 
	var _target = noone;
	var _min_dist = 999999;

	// Encontrar al obj_Player más cercano que NO SEA el mismo bot ni un bot equipo.
	with (obj_Player) {
	    if (hp > 0 && id != other.id && team != other.team) {
	        var _d = point_distance(x, y, other.x, other.y);
	        if (_d < _min_dist) {
	            _min_dist = _d;
	            _target = id;
	        }
	    }
	}
    
    var _potion = instance_nearest(x, y, obj_potion);
    
    _inputs[0] = neural_network.standarScaler(max_hp, 0, hp)  // Salud 
    _inputs[1] = neural_network.standarScaler(max_shield, 0 , shield_); // Escudo
    
    // --- DATOS DEL OBJETIVO ---
    if (instance_exists(_target)) {
        var _dist = point_distance(x, y, _target.x, _target.y);
        var _dir = point_direction(x, y, _target.x, _target.y);
        var _angle = angle_difference(image_angle, _dir); // Ángulo
		
		_inputs[3] = neural_network.standarScaler(180, -180, _angle)  // Angulo

        if (_dist <= vision_radius) {
            _inputs[2] =  neural_network.standarScaler(vision_radius, 0, _dist); // Distancia
                   
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
        if (_dist_p <= vision_radius) {
            _inputs[5] = neural_network.standarScaler(vision_radius, 0, _dist_p);
            var _dir_p = point_direction(x, y, _potion.x, _potion.y);
			var _angle_p = angle_difference(image_angle, _dir_p);
			_inputs[6] = neural_network.standarScaler(180, -180, _angle_p);
        } else {
            _inputs[5] = 1.0; _inputs[6] = -1;
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