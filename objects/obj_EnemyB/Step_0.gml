// 1. BUSCAR OBJETIVO
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

// 2. MÁQUINA DE DECISIONES
// Si tenemos un objetivo válido
if (instance_exists(target)) {
    
    // Zona de Pánico (< 120px): Usar Escudo
    if (min_dist < 120) {
        currentState = botState.SHIELD;
    } 
    // Zona de Ataque: Disparar
    else {
        currentState = botState.RANGED_ATTACK;
    }
}
else {
    // Si no hay nadie, quedarse en "Wander".
    // Como spd = 0, no se moverá, pero rotará mirando puntos aleatorios (idle)
    currentState = botState.WANDER;
}

// 3. EJECUTAR EL CUERPO
event_inherited();

// Correcciones
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);