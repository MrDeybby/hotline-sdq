draw_self();
event_inherited(); 

// Variables
var _radius = 400; 

// 1. DIBUJAR LÍNEAS DE SENSORES (Visualizar lo que ve)
var _player = instance_nearest(x, y, obj_Human);
var _potion = instance_nearest(x, y, obj_potion);

// A. Línea al Jugador
// Usamos la variable 'current_target' que calculamos en get_sensors
if (instance_exists(current_target) && point_distance(x, y, current_target.x, current_target.y) < _radius) {
    var _col = (last_inputs[4] == 1.0) ? c_lime : c_red;
    
    // Dibujar línea hacia el enemigo actual
    draw_line_width_color(x, y, current_target.x, current_target.y, 2, _col, _col);
    
    // Dibujar punto en el enemigo
    draw_circle_color(current_target.x, current_target.y, 4, _col, _col, false);
}

// B. Línea a la Pócima
if (instance_exists(_potion) && point_distance(x, y, _potion.x, _potion.y) < _radius) {
    draw_line_width_color(x, y, _potion.x, _potion.y, 2, c_aqua, c_aqua);
}

// C. Alerta de Peligro
if (last_inputs[7] > 0.5) {
    draw_circle_color(x, y, 60, c_orange, c_orange, true);
    draw_text_transformed_color(x, y - 80, "!", 2, 2, 0, c_orange, c_orange, c_orange, c_orange, 1);
}

// 2. DIBUJAR INTENCIONES (Outputs)
draw_set_alpha(0.1);
draw_circle_color(x, y, _radius, c_yellow, c_yellow, false); // Aura de visión
draw_set_alpha(1);

// Vector Movimiento (Verde)
draw_line_width_color(x, y, x + (input_x * 40), y + (input_y * 40), 3, c_green, c_green);
// Vector Mira (Rojo)
var _aim_len = 50;
draw_line_width_color(x, y, x + lengthdir_x(_aim_len, input_aim_dir), y + lengthdir_y(_aim_len, input_aim_dir), 2, c_fuchsia, c_fuchsia);