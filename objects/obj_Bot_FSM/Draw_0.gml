// Inherit the parent event
event_inherited();

draw_self();
draw_healthbar(x-20, y-40, x+20, y-35, hp, c_black, c_red, c_lime, 0, true, true);

if (is_reloading) {
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_text(x, y - 60, "RECARGANDO...");
    draw_set_color(c_black);
    draw_set_halign(fa_left);
}

draw_self();

if (currentState == botState.SHIELD) {
    draw_set_alpha(0.5);
    draw_set_color(c_aqua); 
    draw_circle(x, y, 40, false); 

    draw_set_alpha(1);
    draw_set_color(c_white); 
}

draw_set_halign(fa_center);
draw_set_color(c_black);
draw_text(x, y - 70, string(string_state_names[currentState]));
draw_set_color(c_black);
draw_set_halign(fa_left);

if (mp_grid_path(global.mp_grid, path, x, y, target_x, target_y, 1))
{	
	
	draw_set_colour(c_blue)
    draw_path(path, x, y, false);
}
