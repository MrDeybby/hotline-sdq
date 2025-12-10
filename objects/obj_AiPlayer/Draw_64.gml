//event_inherited()

if instance_exists(obj_ga_algorithm){
			// Mostrar solo si quieres debug
	//if (!debug_sensors) exit;

			// Mostrar solo si el mouse está cerca del bot
	if (distance_to_point(mouse_x, mouse_y) < 160 || instance_number(obj_AiPlayer) == 1) {

	    var gui_w = display_get_gui_width();
	    var xx = gui_w - 240;
	    var yy = 20;
	    var lh = 20;

	    var s = last_inputs;

	    // FONDO
	    draw_set_color(c_black);
	    draw_set_alpha(0.65);
	    draw_rectangle(xx - 10, yy - 10, gui_w - 10, yy + 350, false);
	    draw_set_alpha(1);

	    // TÍTULO
	    draw_set_color(c_white);
	    draw_set_halign(fa_left);
	    draw_text(xx, yy, "--- SENSORES IA ---");
	    yy += lh * 1.4;

	    // ------------------------------
	    // SUPERVIVENCIA
	    // ------------------------------
	    draw_set_color(c_yellow);
	    draw_text(xx, yy, "[SUPERVIVENCIA]");
	    yy += lh;
	    draw_set_color(c_white);

	    // HP con color
	    if (s[0] < 0.3) draw_set_color(c_red);
	    draw_text(xx, yy, "HP        : " + string_format(s[0], 0, 2));
	    yy += lh;
	    draw_set_color(c_white);

	    draw_text(xx, yy, "Escudo    : " + string_format(s[1], 0, 2));
	    yy += lh;

		if (s[7] == 1) draw_set_color(c_red);
		draw_text(xx, yy, "Reloading : " + string(s[7]));
		yy += lh;
		draw_set_color(c_white);
	    // ------------------------------
	    // VISIÓN Y COMBATE
	    // ------------------------------
	    yy += 5;
	    draw_set_color(c_yellow);
	    draw_text(xx, yy, "[VISION]");
	    yy += lh;
	    draw_set_color(c_white);

	    // Ve al player?
	    if (s[4] == 1) draw_set_color(c_lime);
	    draw_text(xx, yy, "Player Vis: " + string(s[4]));
	    yy += lh;
	    draw_set_color(c_white);

	    draw_text(xx, yy, "P.Distance: " + string_format(s[2], 0, 2));
	    yy += lh;

	    draw_text(xx, yy, "P.Angle   : " + string_format(s[3], 0, 2));
	    yy += lh;

	    // ------------------------------
	    // ENTORNO Y OBJETOS
	    // ------------------------------
	    yy += 5;
	    draw_set_color(c_yellow);
	    draw_text(xx, yy, "[ENTORNO]");
	    yy += lh;
	    draw_set_color(c_white);

	    draw_text(xx, yy, "PotionDist: " + string_format(s[5], 0, 2));
	    yy += lh;

	    if (s[6] == 1) draw_set_color(c_lime);
	    draw_text(xx, yy, "Potion?   : " + string(s[6]));
	    yy += lh;
	    draw_set_color(c_white);

	    // ------------------------------
	    // PELIGRO (BALAS)
	    // ------------------------------
	    yy += 5;
	    draw_set_color(c_yellow);
	    draw_text(xx, yy, "[PELIGRO]");
	    yy += lh;
	    draw_set_color(c_white);

	    if (s[8] > 0.5) draw_set_color(c_red);
	    draw_text(xx, yy, "P.Cercano : " + string_format(s[8], 0, 2));
	    yy += lh;
	    draw_set_color(c_white);

	    if (s[9] > 0.5) draw_set_color(c_red);
	    draw_text(xx, yy, "P.Medio   : " + string_format(s[9], 0, 2));
	    yy += lh;
	    draw_set_color(c_white);
	}
}