draw_set_font(fnt_menu);
draw_set_halign(fa_center); // Centrar texto horizontalmente
draw_set_valign(fa_middle); // Centrar texto verticalmente

var _cw = display_get_gui_width();
var _ch = display_get_gui_height();

for (var i = 0; i < array_length(options); i++) {
    
    if (i == index) {
        draw_set_color(c_yellow);
        draw_text(_cw / 2, _ch / 2 + (op_space * i), "> " + options[i] + " <");
    } 
    else {
        draw_set_color(c_white);
        draw_text(_cw / 2, _ch / 2 + (op_space * i), options[i]);
    }
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);