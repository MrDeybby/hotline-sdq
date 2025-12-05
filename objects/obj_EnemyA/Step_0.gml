// 1. Buscar objetivo
var _target = noone;
var _min_dist = 999999;

with (obj_Player) {
    if (hp > 0 && id != other.id && team != other.team) {
        var _d = point_distance(x, y, other.x, other.y);
        if (_d < _min_dist) {
            _min_dist = _d;
            _target = id;
        }
    }
}

// 2. Comportamiento
var _potion = instance_nearest(x, y, obj_potion);
input_melee = false; 

// Prioridad 1: Sobrevivir
if (hp < (max_hp * 0.3) && instance_exists(_potion)) {
    target_x = _potion.x;
    target_y = _potion.y;
}
// Prioridad 2: Combate
else if (instance_exists(_target) && _min_dist < sight_range) {
    
    // Perseguir
    target_x = _target.x;
    target_y = _target.y;
    
    // Apuntar
    input_aim_dir = point_direction(x, y, _target.x, _target.y);
    
    // Melee
    if (_min_dist < 60) {
        input_melee = true;
    }
}
// Prioridad 3: Patrullar
else {
    target_x = wander_x;
    target_y = wander_y;
    
    input_aim_dir = point_direction(x, y, wander_x, wander_y);
}

// 3. Movimiento
event_inherited();

x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);