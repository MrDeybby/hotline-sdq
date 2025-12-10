

// Verificamos que target exista
if (!instance_exists(target) && (currentState == botState.MELEE || currentState == botState.RANGED_ATTACK || currentState == botState.EVADE)) {
    currentState = botState.WANDER;
}

switch (currentState){
	
	// case botState.IDLE:  	 
		// target_x = x;
		//target_y = y;
		//break;
		
	case botState.MELEE:
		target_x = target.x;
		target_y = target.y;
		
	    // Apuntar
	    input_aim_dir = point_direction(x, y, target.x, target.y);
	    // Melee
	    if (min_dist < 60) {
	        input_melee = true;
	    }
		calculate_path()
		break;
	
	case botState.EVADE:
		var flee_base = point_direction(target.x, target.y, x, y);
		var best_x = x;
		var best_y = y;
		var best_score = -100000;

		
		for (var i = -4; i <= 4; i++) {
		    var flee_dir = flee_base + i * 25;

		    var tx = x + lengthdir_x(200, flee_dir);
		    var ty = y + lengthdir_y(200, flee_dir);

		    
		    if (collision_line(x, y, tx, ty, obj_wall, false, true)) continue;

		    // Distancia al jugador
		    var dist = point_distance(tx, ty, target.x, target.y);

		    // Penalización si apunta a esquinas o bordes
		    if (tx < 32 || tx > room_width - 32) dist -= 80;
		    if (ty < 32 || ty > room_height - 32) dist -= 80;

		    // Elegir mejor dirección sin usar path todavía
		    if (dist > best_score) {
		        best_score = dist;
		        best_x = tx;
		        best_y = ty;
		    }
		}


		if (mp_grid_path(global.mp_grid, path, x, y, best_x, best_y, false)) {
		    target_x = best_x;
		    target_y = best_y;
		} else {
		    // Si no hay camino, plan B: mover diagonales cortas
		    var ang = flee_base + irandom_range(-60, 60);
		    target_x = x + lengthdir_x(100, ang);
		    target_y = y + lengthdir_y(100, ang);
		}

	    // Después de evaluar todo, asignar
	    target_x = best_x;
	    target_y = best_y;
		calculate_path()
		break;
	
	case botState.FIND_AID:
		if instance_exists(potion){
			target_x = potion.x;
			target_y = potion.y;
			calculate_path()
		} else if (instance_exists(obj_potion)){
			var _min_dist_potion = 999999;
			var _potion_target = noone;
			with (obj_potion) {
		        var _d = point_distance(x, y, other.x, other.y);
		        if (_d < _min_dist_potion) {
		            _min_dist_potion = _d;
		            _potion_target = id;
				}
			}
			if _min_dist_potion < sight_range {
				target_x = _potion_target.x;
				target_y = _potion_target.y;
				calculate_path()
			}
			
		} else {
		
		currentState = botState.WANDER
		}
		break;
		
	case botState.RANGED_ATTACK:
		// Apuntar
	    input_aim_dir = point_direction(x, y, target.x, target.y);
	    // Validar visión
	    if (!collision_line(x, y, target.x, target.y, obj_wall, false, false)) {
	        input_shoot = true;
		}
		input_x = 0
		input_y = 0
		break;
	
	case botState.SHIELD:
		input_shield = true;
	
	case botState.WANDER:
		target_x = wander_x;
	    target_y = wander_y;
		
	    if (point_distance(x, y, wander_x, wander_y) > 4) {
             input_aim_dir = point_direction(x, y, wander_x, wander_y);
        }
		calculate_path()
		break;
}

// show_debug_message("Estado: " + string(currentState) + "X: " + string(target_x) + "Y: " + string(target_y));

// Inherit the parent event
event_inherited();