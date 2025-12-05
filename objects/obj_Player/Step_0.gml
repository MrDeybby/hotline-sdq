var _key_right = keyboard_check(ord("D"));
var _key_left = keyboard_check(ord("A"));
var _key_down = keyboard_check(ord("S"));
var _key_up = keyboard_check(ord("W"));
var _key_shield = keyboard_check(vk_space); // Tecla Espacio para escudo

if (_key_shield && shield_ > 0 && !shield_broken) {
    state = "shield";
    shield_ -= 0.5; // Gastar escudo
    if (shield_ <= 0) {
        shield_broken = true;
        alarm[2] = 120; // 2 segundos roto
    }
} else {
    state = "move";
    if (shield_ < max_shield && !shield_broken) shield_ += 0.2; // Regenerar
}

var _hspd = 0;
var _vspd = 0;

if (state == "move") {
    var _move_x = _key_right - _key_left;
    var _move_y = _key_down - _key_up;
    
    // Calcular dirección y velocidad
    var _dir = point_direction(0, 0, _move_x, _move_y);
    var _len = (_move_x != 0 || _move_y != 0) ? spd : 0;
    
    _hspd = lengthdir_x(_len, _dir);
    _vspd = lengthdir_y(_len, _dir);
    
    
    if (mouse_check_button(mb_left) && can_shoot && !is_reloading && current_ammo > 0) {
    can_shoot = false;
    alarm[0] = 20; 

    current_ammo -= 1;

    var _p = instance_create_layer(x, y, "Instances", obj_projectile);
    _p.direction = point_direction(x, y, mouse_x, mouse_y);
    _p.image_angle = _p.direction;
    _p.speed = 10;
    _p.owner = id;

    // SI ME QUEDO SIN BALAS -> RECARGAR AUTOMÁTICAMENTE
    if (current_ammo <= 0) {
        is_reloading = true;
        alarm[3] = reload_time; // Activar Alarma 3 para recargar (3 segundos)
    }
}
    
    if (mouse_check_button_pressed(mb_right) && can_melee) {
        can_melee = false;
        alarm[1] = 40; 
        
        var _dir_atk = point_direction(x, y, mouse_x, mouse_y);
        var _h = instance_create_layer(x + lengthdir_x(30, _dir_atk), y + lengthdir_y(30, _dir_atk), "Instances", obj_hitbox);
        _h.owner = id;
        _h.image_angle = _dir_atk;
    }
}

move_and_collide(_hspd, _vspd, obj_wall);

// 5. MUERTE Y REINICIO
if (hp <= 0) {
    // 1. Resetear el contador de cofres (porque empezamos de cero)
    global.chests_collected = 0;
    
    // 2. Verificar en qué modo estamos para saber a dónde volver
    if (global.game_mode == "AI") {
        // Si es modo IA, ir al primer nivel de IA
        // ¡Asegúrate de tener creada la sala rm_AILevel1!
        if (room_exists(asset_get_index("rm_AILevel1"))) {
            room_goto(asset_get_index("rm_AILevel1"));
        } else {
            // Seguridad: Si no existe, reiniciar el juego
            game_restart();
        }
    } 
    else {
        // Si es modo HUMAN (o cualquier otro), ir al Nivel 1 normal
        room_goto(rm_Level1);
    }
}


x = clamp(x, 0 + 16, room_width - 16);
y = clamp(y, 0 + 16, room_height - 16);