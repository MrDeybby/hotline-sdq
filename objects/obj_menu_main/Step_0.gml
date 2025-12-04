// MOVIMIENTO
if (keyboard_check_pressed(vk_up)) { index--; if (index < 0) index = array_length(options)-1; }
if (keyboard_check_pressed(vk_down)) { index++; if (index >= array_length(options)) index = 0; }

// MOUSE
var _mouse_x_gui = device_mouse_x_to_gui(0);
var _mouse_y_gui = device_mouse_y_to_gui(0);
var _cw = display_get_gui_width();
var _ch = display_get_gui_height();
var _menu_start_y = (_ch / 2); 

draw_set_font(fnt_menu); 
var _mouse_hovering = false;

for (var i = 0; i < array_length(options); i++) {
    var _y_pos = _menu_start_y + (op_space * i);
    var _text_w = string_width(options[i]);
    var _text_h = string_height(options[i]);
    
    var _x1 = (_cw / 2) - (_text_w / 2);
    var _y1 = _y_pos - (_text_h / 2);
    var _x2 = (_cw / 2) + (_text_w / 2);
    var _y2 = _y_pos + (_text_h / 2);
    
    if (point_in_rectangle(_mouse_x_gui, _mouse_y_gui, _x1, _y1, _x2, _y2)) {
        index = i;
        _mouse_hovering = true;
    }
}

// SELECCIÓN
var _select = false;

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    _select = true;
}

if (mouse_check_button_pressed(mb_left) && _mouse_hovering) {
    _select = true;
}

if (_select) {
    switch (index) {
        case 0: room_goto(rm_menu_human); break; 
        case 1: room_goto(rm_menu_ai); break;    
        case 2: break; 
        case 3: game_end(); break;
    }
}