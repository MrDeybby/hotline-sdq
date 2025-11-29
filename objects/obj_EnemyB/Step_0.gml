// 1. Limpiar inputs al inicio del frame
input_x = 0;
input_y = 0;
input_melee = false;
input_shoot = false;
input_shield = false;

// 2. Detectar al jugador
var _player = instance_nearest(x, y, obj_Human);
var _see_player = false;
var _dist_player = 9999;

if (instance_exists(_player)) {
    _dist_player = point_distance(x, y, _player.x, _player.y);
    // Chequear si hay pared en medio
    _see_player = !collision_line(x, y, _player.x, _player.y, obj_wall, false, false);
}

// 3. MÁQUINA DE ESTADOS LÓGICA

// CASO 1: Jugador muy cerca -> ACTIVAR ESCUDO
if (_dist_player < 100) { // 100 pixeles de radio de pánico
    input_shield = true;
    
}

// CASO 2: Jugador a la vista pero lejos -> DISPARAR
else if (_see_player) {
    // Apuntar
    input_aim_dir = point_direction(x, y, _player.x, _player.y);
    
    // Disparar
    input_shoot = true;
}

// CASO 3: No veo a nadie -> IDLE (Quieto)
else {

}

// 4. Ejecutar Físicas
event_inherited();