// 1. Definir el tamaño de las celdas
var _cell_size = 32; 
var _hcells = room_width div _cell_size;
var _vcells = room_height div _cell_size;

// 2. Crear la rejilla global
global.mp_grid = mp_grid_create(0, 0, _hcells, _vcells, _cell_size, _cell_size);

// 3. Marcar las paredes como obstáculos prohibidos
mp_grid_add_instances(global.mp_grid, obj_wall, false);

// Marcar las púas como obstáculos si quieres que los enemigos las eviten
// mp_grid_add_instances(global.mp_grid, obj_spike, false);