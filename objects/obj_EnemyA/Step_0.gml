// 1. BUSCAR OBJETIVO VÁLIDO (Que no sea yo ni mi equipo)
var _target = noone;
var _min_dist = 999999;

with (obj_Player) {
    // Si está vivo, no soy yo, y es de otro equipo (Aliado vs Enemigo)
    if (hp > 0 && id != other.id && team != other.team) {
        var _d = point_distance(x, y, other.x, other.y);
        if (_d < _min_dist) {
            _min_dist = _d;
            _target = id;
        }
    }
}

// 2. LÓGICA DE COMPORTAMIENTO
var _potion = instance_nearest(x, y, obj_potion);
input_melee = false; 

// Prioridad 1: Curarse si vida baja (< 30%)
if (hp < (max_hp * 0.3) && instance_exists(_potion)) {
    target_x = _potion.x;
    target_y = _potion.y;
}
// Prioridad 2: Atacar al objetivo encontrado
else if (instance_exists(_target)) {
    target_x = _target.x;
    target_y = _target.y;
    
    // Apuntar siempre al objetivo
    input_aim_dir = point_direction(x, y, _target.x, _target.y);
    
    // Si estoy cerca, golpear (Rango aumentado a 60 para asegurar el golpe)
    if (_min_dist < 60) {
        input_melee = true;
    }
}
else {
    // Si no hay nadie, quedarse quieto (o podrías poner patrulla aquí)
    target_x = x;
    target_y = y;
}

// 3. EJECUTAR MOVIMIENTO (Padre)
event_inherited();

// 4. LÍMITES DE SALA
x = clamp(x, 16, room_width - 16);
y = clamp(y, 16, room_height - 16);