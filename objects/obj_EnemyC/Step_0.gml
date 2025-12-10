// 1. BUSCAR OBJETIVO
target = noone;
min_dist = 999999;

input_shoot = false;
input_melee = false;
input_shield = false;

with (obj_Player) {
    if (hp > 0 && id != other.id && team != other.team) {
        var _d = point_distance(x, y, other.x, other.y);
        if (_d < other.min_dist) {
            other.min_dist = _d;
            other.target = id;
        }
    }
}

// 2. BUSCAR RECURSOS
potion = instance_nearest(x, y, obj_potion);

// 3. MÁQUINA DE DECISIONES
// Prioridad 1: Supervivencia
if (hp < (max_hp * 0.3) && instance_exists(potion)) {
    currentState = botState.FIND_AID;
}
// Prioridad 2: Combate Táctico
else if (instance_exists(target)) {
    
	
	var blocked = collision_line(x, y, target.x, target.y, obj_wall, true, true);
	
	
    // Si está pegado a mí (< 60): Pánico Melee
    if (min_dist < 60 and !blocked) {
        currentState = botState.MELEE;
    }
    // Si está cerca (< 250): Huir
    else if (min_dist < 250) {
        currentState = botState.EVADE;
    }
    // Si lo veo pero está lejos: Disparar normal
    else if (min_dist < sight_range and !blocked) {
        currentState = botState.RANGED_ATTACK;
        
    }
    else {
        currentState = botState.WANDER;
    }
}
// Prioridad 3: Nada que hacer
else {
    currentState = botState.WANDER;
}

	
// 4. EJECUTAR CUERPO
event_inherited();

x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);