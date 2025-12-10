var _cell_size = 64; 

var _h_cells = ceil(room_width / _cell_size);
var _v_cells = ceil(room_height / _cell_size);



for (var xx = 0; xx < _h_cells; xx++) {
    for (var yy = 0; yy < _v_cells; yy++) {
        if (mp_grid_get_cell(global.mp_grid, xx, yy)) {
            draw_set_color(c_black);
            draw_rectangle(xx * _cell_size, yy * _cell_size, (xx + 1) * _cell_size, (yy + 1) * _cell_size, false);
        }
    }
}
