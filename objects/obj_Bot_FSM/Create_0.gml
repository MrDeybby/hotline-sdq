// Inherit the parent event
event_inherited();

shield_ = 0;
max_shield = 0;
shield_broken = true;

// Estados
enum botState {
	WANDER,
    SHIELD,
    MELEE,
    RANGED_ATTACK,
	EVADE,
	FIND_AID
}


currentState = botState.WANDER;


sight_range = 300;    // Rango de vision   
wander_radius = 100;    // Rango de Patrullaje
path = path_add();
target_x = x;  
target_y = y; 
_target = noone
_potion = noone

function calculate_path(){
// Calcular ruta
    var _dist = point_distance(x, y, target_x, target_y);
    
    if (_dist > 16) {
        // Pathfinding global
        if (mp_grid_path(global.mp_grid, path, x, y, target_x, target_y, true)) {
            // Siguiente punto
            var _next_x = path_get_point_x(path, 1);
            var _next_y = path_get_point_y(path, 1);
            
            var _dir = point_direction(x, y, _next_x, _next_y);
            
            // Convertir a inputs
            input_x = lengthdir_x(1, _dir);
            input_y = lengthdir_y(1, _dir);
        }
    } else {
        // Destino alcanzado
        input_x = 0;
        input_y = 0;
    }	
}

function go_wander(){
	
	wander_x = x + irandom_range(-wander_radius, wander_radius);
	wander_y = y + irandom_range(-wander_radius, wander_radius);

	// Asegurar que no se salga del cuarto
	wander_x = clamp(wander_x, 16, room_width - 16);
	wander_y = clamp(wander_y, 16, room_height - 16);	
}