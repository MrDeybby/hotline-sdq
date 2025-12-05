var _encontrado = false;
var _intentos = 0;

while (!_encontrado && _intentos < 100) {
    
    // 1. Elegir punto al azar
    var _rango = 500;
    var _tx = x + irandom_range(-_rango, _rango);
    var _ty = y + irandom_range(-_rango, _rango);
    
    // 2. Mantener dentro de la sala
    _tx = clamp(_tx, 64, room_width - 64);
    _ty = clamp(_ty, 64, room_height - 64);
	
    if (!position_meeting(_tx, _ty, obj_wall)) {
        wander_x = _tx;
        wander_y = _ty;
        _encontrado = true; // ¡Éxito! Salimos del bucle
    }
    
    _intentos++;
}

alarm[4] = 180;