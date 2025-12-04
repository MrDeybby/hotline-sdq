// 1. MOVIMIENTO (WASD)
// input_x será -1 (Izquierda), 0 (Quieto) o 1 (Derecha)
input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// 2. APUNTADO (Mouse)
// El personaje mira hacia donde esté el cursor
input_aim_dir = point_direction(x, y, mouse_x, mouse_y);

// 3. ACCIONES
// Click Izquierdo -> Disparar
input_shoot = mouse_check_button(mb_left); 

// Click Derecho -> Golpe Melee
input_melee = mouse_check_button_pressed(mb_right); 

// Espacio -> Escudo
input_shield = keyboard_check(vk_space);

// 4. EJECUTAR FÍSICAS
// Le pasamos estos datos al Padre para que él nos mueva
event_inherited();