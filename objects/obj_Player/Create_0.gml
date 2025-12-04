spd = 4;            // Velocidad
hp = 100;           // Vida
max_hp = 100;

// Escudo
shield_ = 100;
max_shield = 100;
shield_broken = false; 

can_shoot = true;
can_melee = true;

state = "move";


max_ammo = 7;       // Balas máximas
current_ammo = 7;   // Balas actuales
is_reloading = false; // ¿Está recargando?
reload_time = 180;  // 3 segundos (3 * 60 frames)

team = "ally";