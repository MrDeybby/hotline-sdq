// Destruirse al chocar con una pared
if (place_meeting(x, y, obj_wall)) {
    instance_destroy();
}

// Destruirse si sale de la habitación (para no llenar la memoria)
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}