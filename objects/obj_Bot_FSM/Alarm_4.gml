wander_x = x + irandom_range(-wander_radius, wander_radius);
wander_y = y + irandom_range(-wander_radius, wander_radius);

// Asegurar que no se salga del cuarto
wander_x = clamp(wander_x, 16, room_width - 16);
wander_y = clamp(wander_y, 16, room_height - 16);