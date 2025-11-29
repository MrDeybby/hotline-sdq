// 1. MOVIMIENTO
var _key_right = keyboard_check(ord("D"));
var _key_left = keyboard_check(ord("A"));
var _key_down = keyboard_check(ord("S"));
var _key_up = keyboard_check(ord("W"));

// Asignamos al input del padre
input_x = _key_right - _key_left;
input_y = _key_down - _key_up;

// 2. APUNTADO
// El personaje siempre mira hacia el mouse
input_aim_dir = point_direction(x, y, mouse_x, mouse_y);

// 3. ACCIONES
// Disparo (Click Izquierdo)
input_shoot = mouse_check_button_pressed(mb_left);

// Ataque Melee (Click Derecho)
input_melee = mouse_check_button_pressed(mb_right);

// Escudo (Espacio)
input_shield = keyboard_check(vk_space);

// 4. IMPORTANTE: Ejecutar la lógica del Padre
event_inherited();put_melee = keyboard_check_pressed(ord("C")); // Tecla Golpe

// Calcular hacia dónde mira el humano
// Opción A: Apuntar con el Mouse
input_aim_dir = point_direction(x, y, mouse_x, mouse_y);

// TRUCO PARA DEBUG
if (keyboard_check_pressed(ord("K"))) {
    hp_ -= 2;
}
// 2. Ejecutar la lógica del Padre
event_inherited();

