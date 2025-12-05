// Buscar objetivo
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

// Lógica Táctica
var _potion = instance_nearest(x, y, obj_potion);

input_melee = false;
input_shoot = false;

// Prioridad 1: Curarse
if (hp < (max_hp * 0.3) && instance_exists(_potion)) {
    target_x = _potion.x;
    target_y = _potion.y;
}
// Prioridad 2: Combate
else if (instance_exists(_target)) {
    input_aim_dir = point_direction(x, y, _target.x, _target.y);

    // Melee (Desesperado)
    if (_min_dist < 60) {
        target_x = _target.x; 
        target_y = _target.y;
        input_melee = true;
    }
    // Kiting (Huir disparando)
    else if (_min_dist < 250) {
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
    }
    else {
        // Mantener posición
        target_x = x;
        target_y = y;
    }
}

// Movimiento
event_inherited();

x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);