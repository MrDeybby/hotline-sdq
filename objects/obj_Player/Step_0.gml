// 1. GESTIÓN DE ESTADO (Escudo vs Movimiento)
// Usamos 'input_shield' en lugar de 'keyboard_check'
if (input_shield && shield_ > 0 && !shield_broken) {
    state = "shield";
    shield_ -= 0.5; 
    if (shield_ <= 0) {
        shield_broken = true;
        alarm[2] = 120; 
    }
} else {
    state = "move";
    if (shield_ < max_shield && !shield_broken) shield_ += 0.2; 
}

var _hspd = 0;
var _vspd = 0;

if (state == "move") {
    // YA NO calculamos _key_right - _key_left aquí.
    // Usamos input_x / input_y que vienen del Hijo (Human o Bot)
    var _move_x = input_x;
    var _move_y = input_y;
    
    // Calcular dirección y velocidad
    // Nota: input_x/y ya vienen definidos (-1 a 1)
    var _is_moving = (_move_x != 0 || _move_y != 0);
    var _dir = point_direction(0, 0, _move_x, _move_y);
    
    // Usamos 'spd' (asegúrate de tenerla definida en el Create, ej: spd = 4)
    var _len = _is_moving ? spd : 0; 
    
    _hspd = lengthdir_x(_len, _dir);
    _vspd = lengthdir_y(_len, _dir);
    
    
    // 2. DISPARO (Ranged)
    // Usamos 'input_shoot' y 'input_aim_dir' (NO mouse_x)
    if (input_shoot && can_shoot && !is_reloading && current_ammo > 0) {
        can_shoot = false;
        alarm[0] = 20; 
        current_ammo -= 1;
		if (instanceof(obj_AiPlayer)) {
		    shots_fired += 1;
		}


        var _p = instance_create_layer(x, y, "Instances", obj_projectile);
        
        _p.owner = id; // IMPORTANTE: Para saber quién disparó
        _p.damage = 1; // Asignar daño
		_p.team = team;
        
        // CRUCIAL: Usamos input_aim_dir. 
        // El Humano lo calcula con el Mouse, el Bot con matemáticas.
        _p.direction = input_aim_dir; 
        _p.image_angle = input_aim_dir;
        _p.speed = 10;

        // Recarga automática
        if (current_ammo <= 0) {
            is_reloading = true;
            alarm[3] = reload_time; 
        }
    }
    
    // 3. MELEE (Cuerpo a cuerpo)
    if (input_melee && can_melee) {
        can_melee = false;
        alarm[1] = 40; 
        
        // Crear hitbox usando input_aim_dir
        var _spawn_x = x + lengthdir_x(30, input_aim_dir);
        var _spawn_y = y + lengthdir_y(30, input_aim_dir);
        
        var _h = instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_hitbox);
        _h.owner = id;
        _h.image_angle = input_aim_dir;
		_h.team = team;
    }
}

// 4. FÍSICAS
move_and_collide(_hspd, _vspd, obj_wall);


// 5. MUERTE
if (hp <= 0) {
    
    if (team == "ally") {
    
        global.chests_collected = 0;
        
        // Lógica de reinicio
        if (global.game_mode == "AI") {
            if (room_exists(asset_get_index("rm_AILevel1"))) {
                room_goto(asset_get_index("rm_AILevel1"));
            } else {
                game_restart();
            }
        } else {
            // Reiniciar nivel actual o ir a Menu
            room_restart(); 
        }
    }
}

// Límites de sala
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);