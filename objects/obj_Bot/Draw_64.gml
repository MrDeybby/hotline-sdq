// SOLO DIBUJAR SI EL MOUSE ESTÁ CERCA (Para no saturar la pantalla con 50 tablas)
// O si es el único bot en la sala.
if (distance_to_point(mouse_x, mouse_y) < 50 || instance_number(obj_Bot) == 1) {

    var _gui_w = display_get_gui_width();
    var _xx = _gui_w - 220; // Posición X (Pegado a la derecha)
    var _yy = 10;           // Posición Y (Arriba)
    var _lh = 20;           // Altura de línea (Line Height)
    
    // 1. FONDO SEMITRANSPARENTE (Panel negro)
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(_xx - 10, _yy - 10, _gui_w - 10, _yy + 400, false);
    draw_set_alpha(1);
    
    // 2. TÍTULO
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text(_xx, _yy, "--- CEREBRO IA ---"); 
    _yy += _lh * 1.5;
    
    // 3. ESTADO (SUPERVIVENCIA)
    draw_set_color(c_yellow);
    draw_text(_xx, _yy, "[ESTADO]"); _yy += _lh;
    draw_set_color(c_white);
    
    // Colorear vida si es baja
    if (last_inputs[0] < 0.3) draw_set_color(c_red);
    draw_text(_xx, _yy, "HP       : " + string_format(last_inputs[0], 0, 2)); _yy += _lh;
    draw_set_color(c_white);
    
    draw_text(_xx, _yy, "Shield   : " + string_format(last_inputs[1], 0, 2)); _yy += _lh;
    
    // 4. VISIÓN (COMBATE)
    _yy += 5;
    draw_set_color(c_yellow);
    draw_text(_xx, _yy, "[VISION]"); _yy += _lh;
    draw_set_color(c_white);
    
    // Colorear si ve al jugador
    if (last_inputs[4] == 1.0) draw_set_color(c_lime);
    draw_text(_xx, _yy, "Player Vis: " + string(last_inputs[4])); _yy += _lh;
    draw_set_color(c_white);
    
    draw_text(_xx, _yy, "P. Dist   : " + string_format(last_inputs[2], 0, 2)); _yy += _lh;
    draw_text(_xx, _yy, "P. Angle  : " + string_format(last_inputs[3], 0, 2)); _yy += _lh;
    
    // 5. ENTORNO
    _yy += 5;
    draw_set_color(c_yellow);
    draw_text(_xx, _yy, "[ENTORNO]"); _yy += _lh;
    draw_set_color(c_white);
    
    draw_text(_xx, _yy, "Potion Dis: " + string_format(last_inputs[5], 0, 2)); _yy += _lh;
    draw_text(_xx, _yy, "Potion Ang: " + string_format(last_inputs[6], 0, 2)); _yy += _lh;
    
    // Alerta roja si hay peligro
    if (last_inputs[7] > 0.5) draw_set_color(c_red);
    draw_text(_xx, _yy, "DANGER    : " + string(last_inputs[7])); _yy += _lh;
    draw_set_color(c_white);
    
    // 6. DECISIONES (OUTPUTS)
    _yy += 10;
    draw_set_color(c_aqua);
    draw_text(_xx, _yy, "[ACCIONES]"); _yy += _lh;
    draw_set_color(c_white);
    
    draw_text(_xx, _yy, "Move X: " + string_format(input_x, 0, 2)); _yy += _lh;
    draw_text(_xx, _yy, "Move Y: " + string_format(input_y, 0, 2)); _yy += _lh;
    
    if (input_shoot) draw_set_color(c_red);
    draw_text(_xx, _yy, "SHOOT : " + (input_shoot ? "ON" : "OFF")); _yy += _lh;
    draw_set_color(c_white);
    
    if (input_shield) draw_set_color(c_blue);
    draw_text(_xx, _yy, "SHIELD: " + (input_shield ? "ON" : "OFF")); _yy += _lh;
    draw_set_color(c_white);
}