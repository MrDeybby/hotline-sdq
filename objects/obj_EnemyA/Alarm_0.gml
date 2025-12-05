// Elegir un punto random a +/- 100 pixeles de donde estoy
var _dist = 100;
wander_x = x + irandom_range(-_dist, _dist);
wander_y = y + irandom_range(-_dist, _dist);

// Asegurar que no se salga del cuarto
wander_x = clamp(wander_x, 16, room_width - 16);
wander_y = clamp(wander_y, 16, room_height - 16);

// Reiniciar alarma entre 2 y 4 segundos
alarm[0] = room_speed * random_range(2, 4);