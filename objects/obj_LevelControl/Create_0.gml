var _cell_size = 64; 

var _h_cells = ceil(room_width / _cell_size);
var _v_cells = ceil(room_height / _cell_size);

global.mp_grid = mp_grid_create(0, 0, _h_cells, _v_cells, _cell_size, _cell_size);

mp_grid_add_instances(global.mp_grid, obj_wall, false);


global.chests_collected = 0; 
global.chests_target = 0;   

switch (room) {
    case rm_Level1:
        global.chests_target = 2;
        break;
        
    case rm_Level2:
        global.chests_target = 3;
        break;
        
    case rm_Level3:
        global.chests_target = 4;
        break;
        
    case rm_Level4:
        global.chests_target = 5;
        break;
        
}