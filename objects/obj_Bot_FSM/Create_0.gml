// Inherit the parent event
event_inherited();

// Estados
enum botState {
	WANDER,
    SHIELD,
    MELEE,
    RANGED_ATTACK,
	EVADE,
	FIND_AID
}


currentState = botState.WANDER;


sight_range = 300;    // Rango de vision   
wander_radius = 100;    // Rango de Patrullaje
path = path_add();
target_x = x;  
target_y = y; 
_target = noone
_potion = noone