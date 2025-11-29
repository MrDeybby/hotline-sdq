event_inherited(); // Heredar vida, velocidad, etc. del Player

// Variables de IA
path = path_add(); // El camino que calculará
target_x = x;
target_y = y;

// Estadísticas de visión
sight_range = 300;   // Qué tan lejos ve
attack_range = 60;   // Qué tan cerca ataca melee