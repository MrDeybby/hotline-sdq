var _player = instance_nearest(x, y, obj_Player);
var _potion = instance_nearest(x, y, obj_potion);

input_melee = false; 

if (hp < (max_hp * 0.3) && instance_exists(_potion)) {
    target_x = _potion.x;
    target_y = _potion.y;
}
else if (instance_exists(_player)) {
    var _dist = point_distance(x, y, _player.x, _player.y);
    
    //PERSEGUIR
    if (_dist < sight_range) {
        target_x = _player.x;
        target_y = _player.y;
        input_aim_dir = point_direction(x, y, _player.x, _player.y);
        
        // Atacar si está muy cerca
        if (_dist < 30) input_melee = true;
    }
    //WONDER
    else {
        target_x = wander_x;
        target_y = wander_y;
        
        input_aim_dir = point_direction(x, y, target_x, target_y);
    }
}

event_inherited();

x = clamp(x, 0 + 16, room_width - 16);
y = clamp(y, 0 + 16, room_height - 16);