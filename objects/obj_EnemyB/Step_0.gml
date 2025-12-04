// 1. BUSCAR OBJETIVO
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

// 2. LÓGICA TIPO B (TORRETA)
// Forzamos inputs a 0 para asegurar que la IA no intente caminar
input_x = 0;
input_y = 0;
input_shoot = false;
input_shield = false;

// Anulamos el sistema de pathfinding del padre poniendo el destino en mis pies
target_x = x;
target_y = y;

if (instance_exists(_target)) {
    // Girar hacia el objetivo (Esto SÍ lo hace, aunque no camine)
    input_aim_dir = point_direction(x, y, _target.x, _target.y);

    // Zona de Defensa (Escudo)
    if (_min_dist < 120) {
        input_shield = true;
    } 
    // Zona de Ataque (Disparo)
    else {
        // Disparar solo si veo al objetivo (Raycast)
        if (!collision_line(x, y, _target.x, _target.y, obj_wall, false, false)) {
            input_shoot = true;
        }
    }
}

// 3. EJECUTAR FÍSICAS
// Al tener run_spd = 0 (en el Create) e input_x/y = 0, se quedará estático
event_inherited();