
if n_bots == 1{
	exit;	
}
draw_set_font(-1);
draw_set_halign(fa_center);

draw_set_colour(c_white);
draw_text(display_get_gui_width()/2, 20, "Generation " + string(n_generations));
draw_text(display_get_gui_width()/2, 50, "Best Fitness: " + string(best_reward));
draw_text(display_get_gui_width()/2, 80, "N: " + string(instance_number(obj_AiPlayer)));