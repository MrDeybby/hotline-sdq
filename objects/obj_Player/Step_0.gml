// Gestión de estados basada en Inputs Generios
if (input_shield && shield_ > 0) {
    state = "shield";
} else if (state == "shield") {
    state = "move"; 
}

switch (state) {
    case "move":
        // Movimiento usando input_x / input_y
        var is_moving = (input_x != 0 || input_y != 0);
        
        if(is_moving){
            // Normalizamos para que no corra más rápido en diagonal
            var _dir = point_direction(0, 0, input_x, input_y);
            hspd = lengthdir_x(run_spd, _dir);
            vspd = lengthdir_y(run_spd, _dir);
        } else {
            hspd = 0;
            vspd = 0;
        }
        
        // Regenerar escudo
        if (shield_ < max_shield) shield_ += shield_regen;
        
        // Disparo (Ranged)
		if (input_shoot && can_shoot) {
		    var _p = instance_create_layer(x, y, "Instances", obj_projectile);

		    _p.owner = id; // <--- ¡IMPORTANTE! Le decimos: "Yo soy tu dueño"

		    _p.direction = input_aim_dir;
		    _p.image_angle = input_aim_dir;
		    _p.speed = 10; // Aseguramos velocidad

		    can_shoot = false;
		    alarm[0] = shoot_cooldown; 
		}
        
        // Melee
		if (input_melee && can_melee) {
		    // 1. Calcular dónde aparece el golpe (un poco enfrente del jugador)
		    var _distancia_golpe = 20; // Qué tan separado del cuerpo aparece
		    var _spawn_x = x + lengthdir_x(_distancia_golpe, input_aim_dir);
		    var _spawn_y = y + lengthdir_y(_distancia_golpe, input_aim_dir);

		    // 2. Crear el objeto hitbox
		    var _hitbox = instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_hitbox);

		    // 3. Configurarlo
		    _hitbox.owner = id;              // Yo soy el dueño (para no pegarme solo)
		    _hitbox.image_angle = input_aim_dir; // Que el dibujo rote hacia donde miro

		    // 4. Cooldown
		    can_melee = false;
		    alarm[1] = melee_cooldown;
		}
        break;

    case "shield":
        // Defensa: Inmoviliza al jugador
        hspd = 0;
        vspd = 0;
        
        // Gasta escudo 
        shield_ -= 1; 
        if (shield_ <= 0) {
            shield_ = 0;
            state = "move"; 
        }
        break;
}

// Colisiones y Movimiento final
move_and_collide(hspd, vspd, obj_wall);

// Muerte
if(hp_ <= 0){
    instance_destroy(); 
}