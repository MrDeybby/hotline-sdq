// 1. Limpiar inputs
input_x = 0;
input_y = 0;
input_melee = false;
input_shoot = false;
input_shield = false;

// Variables de entorno
var _player = instance_nearest(x, y, obj_Human);
var _potion = instance_nearest(x, y, obj_potion);
var _dist_player = 9999;
var _see_player = false;

// Configuración de Distancias
var _flee_range = 250;   // Si estás más cerca que esto, huye
var _panic_range = 50;   // Si estás pegado a él, te golpea

if (instance_exists(_player)) {
    _dist_player = point_distance(x, y, _player.x, _player.y);
    _see_player = !collision_line(x, y, _player.x, _player.y, obj_wall, false, false);
}

// --- MÁQUINA DE ESTADOS DE PRIORIDAD ---

// PRIORIDAD 1: Supervivencia (Buscar Pócima si vida < 30%)
if (hp_ < (max_hp * 0.3) && instance_exists(_potion)) {
    target_x = _potion.x;
    target_y = _potion.y;
}

// PRIORIDAD 2: Combate (Si veo al jugador)
else if (instance_exists(_player) && (_dist_player < sight_range || _see_player)) {
    
    // A. Apuntar siempre al jugador (para disparar o pegar)
    input_aim_dir = point_direction(x, y, _player.x, _player.y);
    
    // B. Lógica de Movimiento: ¿Huir o Perseguir?
    if (_dist_player < _flee_range) {
        // --- ESTADO: HUIDA ---
        // Calcular un punto en dirección OPUESTA al jugador
        var _flee_dir = point_direction(_player.x, _player.y, x, y);
        
        // Intentar moverse 300 pixeles en esa dirección
        target_x = x + lengthdir_x(300, _flee_dir);
        target_y = y + lengthdir_y(300, _flee_dir);
        
        // Asegurar que el punto destino no se salga del cuarto
        target_x = clamp(target_x, 0, room_width);
        target_y = clamp(target_y, 0, room_height);
    } else {
        // --- ESTADO: MANTENER POSICIÓN / ACERCARSE ---
        // Si el jugador se aleja mucho, lo seguimos un poco para no perderlo
        target_x = _player.x;
        target_y = _player.y;
    }
    
    // C. Lógica de Ataque
    if (_dist_player < _panic_range) {
        // "Si está demasiado cerca lo ataca de vuelta" (Melee)
        input_melee = true;
    } else if (_see_player) {
        // Si no está en pánico y lo veo -> DISPARAR
        input_shoot = true;
    }
}
else {
    // Si no pasa nada, quedarse quieto
    target_x = x;
    target_y = y;
}

// Ejecutar movimiento (Herencia del Padre)
event_inherited();