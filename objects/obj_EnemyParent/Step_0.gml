// Movimiento (Pathfinding)

// Si escudo, detener
if (input_shield) {
    input_x = 0;
    input_y = 0;
} 
else {
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

// Gestión Muerte / Nivel
if (hp <= 0) {
    // Siguiente nivel (si es último)
    if (instance_number(obj_EnemyParent) <= 1) {
        
        switch (room) {
            case rm_AILevel1_A: room_goto(rm_AILevel1_B); break;
            case rm_AILevel1_B: room_goto(rm_AILevel1_C); break;
            case rm_AILevel1_C: room_goto(rm_AILevel2_A); break; 
            
            case rm_AILevel2_A: room_goto(rm_AILevel2_B); break; 
            case rm_AILevel2_B: room_goto(rm_AILevel2_C); break; 
            case rm_AILevel2_C: room_goto(rm_AILevel3_A); break; 
            
            case rm_AILevel3_A: room_goto(rm_AILevel3_B); break;
            case rm_AILevel3_B: room_goto(rm_AILevel3_C); break;
            case rm_AILevel3_C: room_goto(rm_AILevel4);   break;
            
            case rm_AILevel4:   room_goto(rm_menu_main); break;
            
            case rm_Level1: room_goto(rm_Level2); break;
            case rm_Level2: room_goto(rm_Level3); break;
            case rm_Level3: room_goto(rm_Level4); break;
            case rm_Level4: room_goto(rm_menu_main); break;
            
            default: room_goto(rm_menu_main); break;
        }
    }
    
    // Destruir
    instance_destroy();
}

// Límites sala
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);

// Heredar físicas
event_inherited();