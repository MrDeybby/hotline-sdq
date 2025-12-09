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

max_ammo = 7;
current_ammo = 7;   
is_reloading = false;
reload_time = 180;  

team = "ally";

input_x = 0;
input_y = 0;
input_shoot = false;
input_melee = false;
input_shield = false;
input_aim_dir = 0;


start_x = x;
start_y = y;