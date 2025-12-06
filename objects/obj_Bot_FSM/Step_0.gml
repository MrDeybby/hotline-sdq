
switch (currentState){
	
	case botState.IDLE:  	 
		target_x = x;
		target_y = y;
		break;
	
	case botState.MELEE:
		target_x = _target.x;
		target_y = _target.y;
    
	    // Apuntar
	    input_aim_dir = point_direction(x, y, _target.x, _target.y);
	    input_melee = true;
		break;
	
	case botState.EVADE:
		// Punto de huida
        var _flee_dir = point_direction(_target.x, _target.y, x, y);

        target_x = x + lengthdir_x(200, _flee_dir);
        target_y = y + lengthdir_y(200, _flee_dir);
        
        // Límites mapa
        target_x = clamp(target_x, 16, room_width - 16);
        target_y = clamp(target_y, 16, room_height - 16);

        // Disparar si visible
        if (!collision_line(x, y, _target.x, _target.y, obj_wall, false, false)) {
            input_shoot = true;
        }
		break;
	
	case botState.FIND_AID:
		target_x = _potion.x;
		target_y = _potion.y;
		break;
		
	case botState.RANGED_ATTACK:
		// Apuntar
	    input_aim_dir = point_direction(x, y, _target.x, _target.y);
	    // Validar visión
	    if (!collision_line(x, y, _target.x, _target.y, obj_wall, false, false)) {
	        input_shoot = true;
		}
		break;
	
	case botState.SHIELD:
		input_shield = true;
	
	case botState.WANDER:
		if (alarm[4] <= -1) {
		    alarm[4] = room_speed * 2;
		}
		target_x = wander_x;
	    target_y = wander_y;
    
	    input_aim_dir = point_direction(x, y, wander_x, wander_y);
		break;
}



// Inherit the parent event
event_inherited();