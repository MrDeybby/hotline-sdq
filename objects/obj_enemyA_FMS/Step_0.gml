// 1. Buscar objetivo
target = noone;
min_dist = 999999;

with (obj_Player) {
    if (hp > 0 && id != other.id && team != other.team) {
        var _d = point_distance(x, y, other.x, other.y);
        if (_d < other.min_dist) {
            other.min_dist = _d;
            other.target = id;
        }
    }
}

// 2. Comportamiento
potion = instance_nearest(x, y, obj_potion);
input_melee = false; 

// Prioridad 1: Sobrevivir
if (hp < (max_hp * 0.3) && instance_exists(potion)) {
    currentState = botState.FIND_AID
}
// Prioridad 2: Combate
else if (instance_exists(target) && min_dist < sight_range) {
    
    currentState = botState.MELEE
}
// Prioridad 3: Patrullar
else {
    currentState = botState.WANDER
}

// 3. Movimiento
event_inherited();

x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16)