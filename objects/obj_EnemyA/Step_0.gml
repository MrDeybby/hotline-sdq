// 1. BUSCAR OBJETIVO
min_dist = 999999;

with (obj_Player) {
    // Buscar: Vivo + No soy yo + Equipo contrario
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

// 3. MÁQUINA DE DECISIONES (CEREBRO)
// Prioridad 1: Supervivencia (Vida < 30%)
if (hp < (max_hp * 0.3) && instance_exists(potion)) {
    currentState = botState.FIND_AID;
}
// Prioridad 2: Combate (Si hay target y está en rango)
else if (instance_exists(target) && min_dist < sight_range) {
    currentState = botState.MELEE;
}
// Prioridad 3: Patrullar (Por defecto)
else {
    currentState = botState.WANDER;
}

// 4. EJECUTAR EL CUERPO (Padre)
event_inherited();

// 5. CORRECCIONES FÍSICAS
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);