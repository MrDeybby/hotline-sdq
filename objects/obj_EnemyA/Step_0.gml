input_melee = false;

// Variables locales para facilitar lectura
var _player = instance_nearest(x, y, obj_Human);
var _potion = instance_nearest(x, y, obj_potion);
var _dist_player = (instance_exists(_player)) ? point_distance(x, y, _player.x, _player.y) : 9999;
var _see_player = (instance_exists(_player)) ? !collision_line(x, y, _player.x, _player.y, obj_wall, false, false) : false;

// --- MÁQUINA DE ESTADOS LÓGICA ---

// PRIORIDAD 1: Supervivencia (Buscar Pócima si vida < 30%)
if (hp_ < (max_hp * 0.3) && instance_exists(_potion)) {
    target_x = _potion.x;
    target_y = _potion.y;
    // La lógica de movimiento del Padre (Inherited) nos llevará allá
}
// PRIORIDAD 2: Ataque (Si veo al jugador o está cerca)
else if (instance_exists(_player) && (_dist_player < sight_range || _see_player)) {
    
    target_x = _player.x;
    target_y = _player.y;
    
    // Si estoy suficientemente cerca, GOLPEAR
	if (_dist_player <= 60) { 
	        input_melee = true; 
	        input_aim_dir = point_direction(x, y, _player.x, _player.y);
	    }
}
// PRIORIDAD 3: Idle (Quedarse quieto)
else {
    target_x = x;
    target_y = y;
}

// Ejecutar movimiento (Llamar al Padre Enemy -> Padre Player)
event_inherited();