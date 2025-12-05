/// MOTOR CENTRAL DEL ENEMIGO (VERSION FINAL MEJORADA)

// --- 1. INTELIGENCIA DEFENSA (AUTO-ESCUDO + RECARGA SEGURA) ---
// Solo si tengo capacidad de escudo
if (variable_instance_exists(id, "max_shield") && max_shield > 0) {
    
    // CASO A: ESTOY RECARGANDO (NUEVO)
    // Si estoy indefenso recargando, levanto el escudo obligatoriamente
    if (is_reloading) {
        input_shield = true;
    }
    
    // CASO B: VEO UNA BALA VENIR
    else {
        var _bullet = instance_nearest(x, y, obj_projectile);
        if (instance_exists(_bullet)) {
            // Si la bala no es mía y está cerca (< 100px)
            if (variable_instance_exists(_bullet, "owner") && _bullet.owner != id) {
                if (point_distance(x, y, _bullet.x, _bullet.y) < 100) {
                    input_shield = true;
                }
            }
        }
    }
}


// --- 2. GESTIÓN DE ESCUDO ---
if (variable_instance_exists(id, "input_shield") && input_shield) {
    input_x = 0;
    input_y = 0;
    
    // Gastar escudo
    if (variable_instance_exists(id, "shield_")) {
        shield_ -= 0.5;
        if (shield_ < 0) shield_ = 0;
    }
}
// Regenerar escudo (Solo si NO se usa)
else if (variable_instance_exists(id, "shield_") && shield_ < max_shield) {
    shield_ += 0.2;
}


// --- 3. PATHFINDING ---
var _dist = point_distance(x, y, target_x, target_y);

if (_dist > 16) {
    if (mp_grid_path(global.mp_grid, path, x, y, target_x, target_y, true)) {
        // A. CAMINO ENCONTRADO
        var _next_x = path_get_point_x(path, 1);
        var _next_y = path_get_point_y(path, 1);
        
        var _dir = point_direction(x, y, _next_x, _next_y);
        input_x = lengthdir_x(1, _dir);
        input_y = lengthdir_y(1, _dir);
        
        // WONDER FLUIDO
        if (target_x == wander_x && target_y == wander_y) {
            if (_dist < 60) alarm[4] = 1; 
        }
    } 
    else {
        // B. CAMINO BLOQUEADO
        input_x = 0;
        input_y = 0;
        if (target_x == wander_x && target_y == wander_y) alarm[4] = 1;
    }
} else {
    input_x = 0;
    input_y = 0;
}


// --- 4. MOTOR FÍSICO ---
var _is_moving = (input_x != 0 || input_y != 0);
var _current_spd = _is_moving ? spd : 0;

hspd = lengthdir_x(_current_spd, point_direction(0, 0, input_x, input_y));
vspd = lengthdir_y(_current_spd, point_direction(0, 0, input_x, input_y));

move_and_collide(hspd, vspd, obj_wall);

// Mantener en el mapa
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);


// --- 5. DISPARO CON MUNICIÓN ---
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


// --- 6. MUERTE Y VICTORIA ---
if (hp <= 0) {
    if (instance_number(obj_EnemyParent) <= 1) {
        switch (room) {
            case rm_AILevel1_A: room_goto(rm_AILevel1_B); break;
            case rm_AILevel1_B: room_goto(rm_AILevel1_C); break;
            case rm_AILevel1_C: room_goto(rm_AILevel2_A); break; 
            case rm_AILevel2_A: room_goto(rm_AILevel2_B); break;
            case rm_AILevel2_B: room_goto(rm_AILevel2_C); break;
            case rm_AILevel2_C: room_goto(rm_AILevel3_A); break; 
            case rm_AILevel3_A: room_goto(rm_AILevel3_B); break;
            case rm_AILevel3_B: room_goto(rm_AILevel3_C); break;
            case rm_AILevel3_C: room_goto(rm_AILevel4);   break;
            case rm_AILevel4:   room_goto(rm_menu_main); break;
            case rm_Level1: room_goto(rm_Level2); break;
            case rm_Level2: room_goto(rm_Level3); break;
            case rm_Level3: room_goto(rm_Level4); break;
            case rm_Level4: room_goto(rm_menu_main); break;
            default: room_goto(rm_menu_main); break;
        }
    }
    instance_destroy();
}