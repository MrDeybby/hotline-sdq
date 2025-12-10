// Inherit the parent event
event_inherited();

current_target = noone;

// Configuración IA
is_bot = true;

// Crear cerebro
neural_network = instance_create_layer(x, y, "Instances", obj_neural_network); 

// Configurar capas
var _cfg = global.nn_shooter_config;
var _topology = [];

// 1. Agregar capa de Entrada
array_push(_topology, _cfg.inputs);

// 2. Agregar las capas ocultas
var _layers_array = _cfg.hidden_layers;
for (var i = 0; i < array_length(_layers_array); i++) {
    array_push(_topology, _layers_array[i]);
}

// 3. Agregar capa de Salida
array_push(_topology, _cfg.outputs);

// Inicializar
neural_network.init_network(_topology);

//team = "enemy";
//show_debug_message(string(hp));

// Estadistica de mejor gen
log_stats = false;
counter = 1;
// Variables Fitness
fitness = -100;
time_alive = 0;
damage_dealt = 0; 

life_taken = 0;
total_deaths = 0;
state_changes = 0;


shots_fired = 0; // quitar esto
shots_hit = 0; // quitar esto

start_x = x;
start_y = y;

// Debug visual
last_inputs = array_create(10, 0);
last_outputs = array_create(6, 0);


frames_alive = 0;
state_changes_counter = 0;
//last_state = botState.WANDER;
currentState = botState.WANDER;
vision_radius = 200;
wander_radius = 150;





alarm[4] = 1;

// Mascara de color
hue_shift = noone // El color se da al crear el objeto en el algoritmo genetico

max_bullet = int64(global.ga_config[$"time_alive"]/ 5 * 7)
max_seconds_alives = global.ga_config[$"time_alive"]

// Funcion para cambiar el color del auto
function change_hue_shift(_hue) {
	hue_shift = _hue
	image_blend = make_color_hsv(hue_shift, 200, 255);
}


function get_fitness(w1=1, w2=1, w3=1, w4=1) {
	var seconds_alive = (time_alive) / room_speed;
	
	var h1 = standarScaler(max_seconds_alives, 0, seconds_alive); // Tiempo con vida
	var h2 = total_deaths / obj_ga_algorithm.total_enemies;
	var h3 = damage_dealt / (damage_dealt + 1); // Total de daño 
	var h4 =  life_taken / (life_taken + 1);
	//var h5 = state_changes / (state_changes + max_seconds_alives);
	show_debug_message("Tiempo en vida: " + string(seconds_alive) + "Normalizado: " + string(h1));	
	show_debug_message("Cantidad de kills: " + string(total_deaths) + "Normalizado: " + string(h2));	
	show_debug_message("Daño hecho: " + string(damage_dealt) + "Normalizado: " + string(h3));	
	show_debug_message("Vida perdida: " + string(life_taken) + "Normalizado: " + string(h4));	
	show_debug_message("Fitness Total: " + string((h1 * w1) + (h2 * w2) + (h3 * w3) - (h4 * w4)));
	
	return (h1 * w1) + (h2 * w2) + (h3 * w3) - (h4 * w4);
}

// Sensores entorno
function get_sensors() {
	
    var _inputs = array_create(10, 0); 
	
	min_dist = 999999;



	with (obj_Player) {
	    // Buscar: Vivo + No soy yo + Equipo contrario
	    if (hp > 0 && id != other.id && team != other.team) {
	        var _d = point_distance(x, y, other.x, other.y);
	        if (_d < other.min_dist) {
	            other.min_dist = _d;
	            other.target = id;
	        }
	    }
	}
    
    var _potion = instance_nearest(x, y, obj_potion);
    
    _inputs[0] = standarScaler(max_hp, 0, hp)  // Salud 
    _inputs[1] = standarScaler(max_shield, 0 , shield_); // Escudo
    
    // --- DATOS DEL OBJETIVO ---
    if (instance_exists(target)) {
        var _dist = point_distance(x, y, target.x, target.y);
        var _dir = point_direction(x, y, target.x, target.y);
        var _angle = angle_difference(image_angle, _dir); // Ángulo
		
		_inputs[3] = standarScaler(180, -180, _angle)  // Angulo

        if (_dist <= vision_radius) {
            _inputs[2] =  standarScaler(vision_radius, 0, _dist); // Distancia
                   
            var _wall = collision_line(x, y, target.x, target.y, obj_wall, false, true);
            _inputs[4] = (_wall == noone) ? 1.0 : 0.0; // Visión
        } else {
            // Fuera de rango
            _inputs[2] = 1.0;
			_inputs[4] = 0.0; 
        }
    } else {
        // No hay nadie vivo en la sala
        _inputs[2] = 1.0; _inputs[3] = 0.5; _inputs[4] = 0.0;
    }
    
    // --- 4. RECURSOS (Pócima) ---
    if (instance_exists(_potion)) {
        var _dist_p = point_distance(x, y, _potion.x, _potion.y);
			
        if (_dist_p <= vision_radius) {
            _inputs[5] = standarScaler(vision_radius, 0, _dist_p);   
        } else {
            _inputs[5] = 1.0;
        }
		
		_inputs[6] = 1.0 // Si hay posima
		
    } else { 
        _inputs[5] = 1.0; _inputs[6] = 0.0; // Si no hay posima 
    }
    
	_inputs[7] = is_reloading? 1.0: 0.0; // Recargando?	
	
	// --- 5. PELIGRO ---

	var NEAR_RANGE  = 80;
	var MID_RANGE   = 160;

	var near_bullets = 0;
	var mid_bullets  = 0;

	with (obj_projectile) {
	    // Ignorar mis propias balas
	    if (owner == other.id) continue;

	    var d = point_distance(other.x, other.y, x, y);

	    if (d < NEAR_RANGE) {
	        near_bullets++;
	    } else if (d < MID_RANGE) {
	        mid_bullets++;
	    }
	}

	
	_inputs[8] = clamp(near_bullets / 3, 0, 1);
	_inputs[9]   = clamp(mid_bullets  / 3, 0, 1);

    
    return _inputs;
}