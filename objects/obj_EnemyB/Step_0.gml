// 1. Buscar objetivo
var _target = noone;
var _min_dist = 999999;

with (obj_Player) {
    if (hp > 0 && id != other.id && team != other.team) {
        var _d = point_distance(x, y, other.x, other.y);
        if (_d < _min_dist) {
            _min_dist = _d;
            _target = id;
        }
    }
}

// 2. Lógica Torreta
// Reset inputs (Estático)
input_x = 0;
input_y = 0;
input_shoot = false;
input_shield = false;
input_melee = false;

// Anular movimiento
target_x = x;
target_y = y;

if (instance_exists(_target)) {
    // Apuntar
    input_aim_dir = point_direction(x, y, _target.x, _target.y);

    // Defensa
    if (_min_dist < 120) {
        input_shield = true;
    } 
    // Ataque
    else {
        // Validar visión
        if (!collision_line(x, y, _target.x, _target.y, obj_wall, false, false)) {
            input_shoot = true;
        }
    }
}

// 3. Físicas
event_inherited();