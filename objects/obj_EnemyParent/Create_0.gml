event_inherited();

spd = 3;            // Velocidad estándar
hp = 100;           // Vida
max_hp = 100;
hspd = 0;
vspd = 0;

path = path_add();
target_x = x;  
target_y = y; 

input_x = 0;
input_y = 0;
input_shoot = false;
input_melee = false;
input_shield = false;
input_aim_dir = 0;  

can_shoot = true;
can_melee = true;

image_blend = c_red;

max_ammo = 7;     
current_ammo = 7;  
is_reloading = false;
reload_time = 180;   

team = "enemy";