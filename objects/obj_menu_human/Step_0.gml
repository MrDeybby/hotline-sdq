if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    index--;
    if (index < 0) index = array_length(options) - 1;
}
if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    index++;
    if (index >= array_length(options)) index = 0;
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {

    global.game_mode = "HUMAN"; 

    switch (index) {
        case 0: room_goto(rm_Level1); break;
        case 1: room_goto(rm_Level2); break;
        case 2: room_goto(rm_Level3); break;
        case 3: room_goto(rm_Level4); break;
        case 4: room_goto(rm_menu_main); break; // Volver atrás
    }
}