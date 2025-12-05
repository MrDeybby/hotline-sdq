/// CEREBRO: MIXTO (PERSEGUIR + DISPARAR + MELEE)

var _player = instance_nearest(x, y, obj_Player);

// Resetear intenciones de ataque
input_melee = false;
input_shoot = false;

if (instance_exists(_player)) {
    var _dist = point_distance(x, y, _player.x, _player.y);
    
    // 1. MOVIMIENTO: SIEMPRE PERSEGUIR (Como el Enemigo A)
    target_x = _player.x;
    target_y = _player.y;
    
    // Apuntar siempre al jugador
    input_aim_dir = point_direction(x, y, _player.x, _player.y);
    
    
    // 2. COMBATE POR DISTANCIA
    
    // A. DISTANCIA CORTA (< 40px) -> ATAQUE MELEE (Como A)
    if (_dist < 40) {
        input_melee = true;
    }
    
    // B. DISTANCIA MEDIA (< 300px) -> DISPARAR (Como B)
    else if (_dist < 300) {
        // Verificar que no haya pared en medio
        if (!collision_line(x, y, _player.x, _player.y, obj_wall, false, false)) {
            input_shoot = true;
        }
    }
}
else {
    // Si el jugador murió, patrullar (Wonder)
    target_x = wander_x;
    target_y = wander_y;
    input_aim_dir = point_direction(x, y, target_x, target_y);
}

// Ejecutar el motor del Padre (que incluye la defensa automática con escudo)
event_inherited();