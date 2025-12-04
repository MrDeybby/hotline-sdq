if (variable_instance_exists(id, "input_shield") && input_shield) {
    input_x = 0;
    input_y = 0;
    
    // Gastar escudo si tiene
    if (variable_instance_exists(id, "shield_")) {
        shield_ -= 0.5;
        if (shield_ < 0) shield_ = 0;
    }
}
// Regenerar escudo si no se usa
else if (variable_instance_exists(id, "shield_") && shield_ < max_shield) {
    shield_ += 0.2;
}


var _dist = point_distance(x, y, target_x, target_y);

if (_dist > 16) {
    if (mp_grid_path(global.mp_grid, path, x, y, target_x, target_y, true)) {
        // A. SI ENCUENTRA CAMINO -> MOVERSE
        var _next_x = path_get_point_x(path, 1);
        var _next_y = path_get_point_y(path, 1);
        
        var _dir = point_direction(x, y, _next_x, _next_y);
        input_x = lengthdir_x(1, _dir);
        input_y = lengthdir_y(1, _dir);
    } 
    else {
        input_x = 0;
        input_y = 0;
        
        if (target_x == wander_x && target_y == wander_y) {
            alarm[4] = 1;
        }
    }
} else {
    input_x = 0;
    input_y = 0;
}


var _is_moving = (input_x != 0 || input_y != 0);
var _current_spd = _is_moving ? spd : 0;

hspd = lengthdir_x(_current_spd, point_direction(0, 0, input_x, input_y));
vspd = lengthdir_y(_current_spd, point_direction(0, 0, input_x, input_y));

move_and_collide(hspd, vspd, obj_wall);


if (input_shoot && can_shoot && !is_reloading && current_ammo > 0) {
    can_shoot = false;
    alarm[0] = 40; 
    
    current_ammo -= 1;
    
    var _p = instance_create_layer(x, y, "Instances", obj_projectile);
    _p.direction = input_aim_dir;
    _p.image_angle = input_aim_dir;
    _p.speed = 8;
    _p.owner = id;
    
    if (current_ammo <= 0) {
        is_reloading = true;
        alarm[2] = reload_time; 
    }
}

if (input_melee && can_melee) {
    can_melee = false;
    alarm[1] = 60; 
    var _h = instance_create_layer(x + lengthdir_x(30, input_aim_dir), y + lengthdir_y(30, input_aim_dir), "Instances", obj_hitbox);
    _h.owner = id;
    _h.image_angle = input_aim_dir;
}


if (hp <= 0) {
    if (instance_number(obj_EnemyParent) <= 1) {
        
        switch (room) {
            // IA Mundo 1
            case rm_AILevel1_A: room_goto(rm_AILevel1_B); break;
            case rm_AILevel1_B: room_goto(rm_AILevel1_C); break;
            case rm_AILevel1_C: room_goto(rm_AILevel2_A); break; 
            
            // IA Mundo 2
            case rm_AILevel2_A: room_goto(rm_AILevel2_B); break;
            case rm_AILevel2_B: room_goto(rm_AILevel2_C); break;
            case rm_AILevel2_C: room_goto(rm_AILevel3_A); break; 
            
            // IA Mundo 3
            case rm_AILevel3_A: room_goto(rm_AILevel3_B); break;
            case rm_AILevel3_B: room_goto(rm_AILevel3_C); break;
            case rm_AILevel3_C: room_goto(rm_AILevel4);   break;
            
            // IA Final
            case rm_AILevel4:   room_goto(rm_menu_main); break;
            
            // Humano
            case rm_Level1: room_goto(rm_Level2); break;
            case rm_Level2: room_goto(rm_Level3); break;
            case rm_Level3: room_goto(rm_Level4); break;
            case rm_Level4: room_goto(rm_menu_main); break;
            
            default: room_goto(rm_menu_main); break;
        }
    }
    
    instance_destroy();
}