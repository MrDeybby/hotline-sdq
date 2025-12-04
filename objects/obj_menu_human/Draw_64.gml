var _cw = display_get_gui_width();
var _ch = display_get_gui_height();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_font(fnt_title); 
var _titulo_y = _ch * 0.15;

// Sombra del título
draw_set_color(c_black);
draw_text((_cw / 2) + 4, _titulo_y + 4, "SMART TOP DOWN");

// Título principal
draw_set_color(c_white);
draw_text(_cw / 2, _titulo_y, "SMART TOP DOWN");

draw_set_font(fnt_menu);

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