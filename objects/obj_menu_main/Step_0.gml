// MOVIMIENTO (Copiar lógica de flechas arriba/abajo si no la tienes)
if (keyboard_check_pressed(vk_up)) { index--; if (index < 0) index = array_length(options)-1; }
if (keyboard_check_pressed(vk_down)) { index++; if (index >= array_length(options)) index = 0; }

// SELECCIÓN
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    switch (index) {
        case 0: room_goto(rm_menu_human); break; // Ir a Submenú Humano
        case 1: room_goto(rm_menu_ai); break;    // Ir a Submenú AI
        case 2: break; // Configuración (vacío)
        case 3: game_end(); break;
    }
}