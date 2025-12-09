

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
		calculate_path2()
		break;
	
	case botState.EVADE:
		// Punto de huida
        var _flee_dir = point_direction(target.x, target.y, x, y);

        target_x = x + lengthdir_x(200, _flee_dir);
        target_y = y + lengthdir_y(200, _flee_dir);
        
        // Límites mapa
        target_x = clamp(target_x, 16, room_width - 16);
        target_y = clamp(target_y, 16, room_height - 16);

        // Disparar si visible
        if (!collision_line(x, y, target.x, target.y, obj_wall, false, false)) {
            input_shoot = true;
        }
		calculate_path2()
		break;
	
	case botState.FIND_AID:
		target_x = potion.x;
		target_y = potion.y;
		calculate_path2()
		break;
		
	case botState.RANGED_ATTACK:
		// Apuntar
	    input_aim_dir = point_direction(x, y, target.x, target.y);
	    // Validar visión
	    if (!collision_line(x, y, target.x, target.y, obj_wall, false, false)) {
	        input_shoot = true;
		}
		break;
	
	case botState.SHIELD:
		input_shield = true;
	
	case botState.WANDER:
		target_x = wander_x;
	    target_y = wander_y;
		
	    if (point_distance(x, y, wander_x, wander_y) > 4) {
             input_aim_dir = point_direction(x, y, wander_x, wander_y);
        }
		calculate_path2()
		break;
}

// show_debug_message("Estado: " + string(currentState) + "X: " + string(target_x) + "Y: " + string(target_y));

// Inherit the parent event
event_inherited();