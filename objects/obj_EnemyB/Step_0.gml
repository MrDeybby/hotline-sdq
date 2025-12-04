var _player = instance_nearest(x, y, obj_Player);

input_shoot = false;
input_shield = false;

// Quedarse quieto
target_x = x;
target_y = y;

if (instance_exists(_player)) {
    var _dist = point_distance(x, y, _player.x, _player.y);

    // Apuntar al jugador
    input_aim_dir = point_direction(x, y, _player.x, _player.y);

    if (_dist < 120) {
        input_shield = true;
    } 
    else {
        if (!collision_line(x, y, _player.x, _player.y, obj_wall, false, false)) {
            input_shoot = true;
        }
    }
}

event_inherited();

x = clamp(x, 0 + 16, room_width - 16);
y = clamp(y, 0 + 16, room_height - 16);