/// CEREBRO: TÁCTICO / HUIDIZO (CON PATRULLA)

// 1. Detectar al Jugador
var _player = instance_nearest(x, y, obj_Player);

// Resetear intenciones de ataque
input_melee = false;
input_shoot = false;

// 2. MÁQUINA DE ESTADOS
if (instance_exists(_player)) {
    
    // Calcular distancia al jugador
    var _dist = point_distance(x, y, _player.x, _player.y);
    
    // --- ESTADO A: PÁNICO (Muy cerca < 60px) ---
    // Si lo acorralas, deja de huir y te ataca a la desesperada
    if (_dist < 60) {
        target_x = _player.x; 
        target_y = _player.y;
        input_melee = true;   // Activar golpe
        
        // Mirar al jugador
        input_aim_dir = point_direction(x, y, _player.x, _player.y);
    }
    
    else if (_dist < 250) {
        // Calcular dirección opuesta al jugador
        var _flee_dir = point_direction(_player.x, _player.y, x, y);
        
        target_x = x + lengthdir_x(300, _flee_dir);
        target_y = y + lengthdir_y(300, _flee_dir);
        
        if (!collision_line(x, y, _player.x, _player.y, obj_wall, false, false)) {
            input_shoot = true;
        }
        
        input_aim_dir = point_direction(x, y, _player.x, _player.y);
    }
    
    else if (_dist > sight_range) {
        target_x = wander_x; 
        target_y = wander_y;
        
        // Mirar hacia donde camina
        input_aim_dir = point_direction(x, y, target_x, target_y);
    }
    
    else {
        target_x = x; // Quedarse en el sitio
        target_y = y;
        
        input_aim_dir = point_direction(x, y, _player.x, _player.y);
    }
}
else {
    target_x = wander_x;
    target_y = wander_y;
    input_aim_dir = point_direction(x, y, target_x, target_y);
}

event_inherited();