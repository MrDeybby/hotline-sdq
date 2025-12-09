// Inherit the parent event
event_inherited();

var x1 = x;
var y1 = y;

var _dist = point_distance(x, y, target_x, target_y);
var _dir = point_direction(x, y, target_x, target_y);

	
if _dist < sight_range or currentState == botState.FIND_AID{
	
	// Punto final basado en el ángulo
	var x2 = x1 + lengthdir_x(_dist, _dir);
	var y2 = y1 + lengthdir_y(_dist, _dir);
	
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_line(x1, y1, x2, y2);
}
