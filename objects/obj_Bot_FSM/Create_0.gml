// Inherit the parent event
event_inherited();

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

state_names = [ botState.WANDER, botState.SHIELD, botState.MELEE, 
					botState.RANGED_ATTACK, botState.EVADE, botState.FIND_AID ];
string_state_names = ["WANDER", "SHIELD", "MELEE", "RANGED_ATTACK", "EVADE", "FIND_AID"]
sight_range = 300;    // Rango de vision   
wander_radius = 100;    // Rango de Patrullaje
path = path_add();
target_x = x;  
target_y = y; 
target = noone
potion = noone


function calculate_path2(){

    // Si está usando escudo, se queda quieto
    if (input_shield) {
        input_x = 0;
        input_y = 0;
        return;
    }

    var _dist = point_distance(x, y, target_x, target_y);

    // Llegó
    if (_dist < 24){
        input_x = 0;
        input_y = 0;
        return;
    }

    // Dirección hacia el objetivo
    var dir_to_target = point_direction(x, y, target_x, target_y);
    var move_x = lengthdir_x(1, dir_to_target);
    var move_y = lengthdir_y(1, dir_to_target);

    // AVOIDANCE: Revisar si hay pared enfrente
    var check_x = x + move_x * 12;
    var check_y = y + move_y * 12;

    if (collision_line(x, y, check_x, check_y, obj_wall, false, true)){
        
        // Si hay pared, desviamos la dirección
        var avoid_angle = dir_to_target + choose(-60, 60); 
        move_x = lengthdir_x(1, avoid_angle);
        move_y = lengthdir_y(1, avoid_angle);
    }

    // chequear si después de evitar sigue chocando; si sí, desviar más
    var check2_x = x + move_x * 12;
    var check2_y = y + move_y * 12;

    if (collision_line(x, y, check2_x, check2_y, obj_wall, false, true)){
        
        var avoid_angle2 = dir_to_target + choose(-120, 120);
        move_x = lengthdir_x(1, avoid_angle2);
        move_y = lengthdir_y(1, avoid_angle2);
    }

    // Asignar movimiento final
    input_x = move_x;
    input_y = move_y;

    // show_debug_message("Ir X: " + string(input_x) + " Y: " + string(input_y));
}

function calculate_path(){
	// Detener si escudo
	if (input_shield) {
	    input_x = 0;
	    input_y = 0;
	} 
	else {
	    var _dist = point_distance(x, y, target_x, target_y);
    
	    // Tolerancia de llegada
	    if (_dist > 24) {
			
			
	        // Pathfinding (sin diagonales)
	        if (mp_grid_path(global.mp_grid, path, x, y, target_x, target_y, false)) {
           
            
	            var _next_x = path_get_point_x(path, 1);
	            var _next_y = path_get_point_y(path, 1);
            
	            var _dir = point_direction(x, y, _next_x, _next_y);
            
	            input_x = lengthdir_x(1, _dir);
	            input_y = lengthdir_y(1, _dir);
	        }
	        else {
	            // Fallo de camino: Detener
	            input_x = 0;
	            input_y = 0;
            
	            // Movimiento directo (Backup cercanía)
	            if (_dist < 64 && !collision_line(x, y, target_x, target_y, obj_wall, false, false)) {
	                var _dir = point_direction(x, y, target_x, target_y);
	                input_x = lengthdir_x(1, _dir);
	                input_y = lengthdir_y(1, _dir);
	            }
	        }
	    } else {
	        // Llegada
	        input_x = 0;
	        input_y = 0;

	    }
		
	// show_debug_message("Ir X: " + string(input_x) + " Y: " + string(input_y) )
	}
}
function go_wander(){
	
	wander_x = x + irandom_range(-wander_radius, wander_radius);
	wander_y = y + irandom_range(-wander_radius, wander_radius);

	// Asegurar que no se salga del cuarto
	wander_x = clamp(wander_x, 16, room_width - 16);
	wander_y = clamp(wander_y, 16, room_height - 16);	
}