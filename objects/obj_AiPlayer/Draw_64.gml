var _gui_w = display_get_gui_width();
var _xx = _gui_w - 220; // Posición X (Pegado a la derecha)
var _yy = 10;           // Posición Y (Arriba)
var _lh = 20;           // Altura de línea (Line Height)

var _target = noone;
	var _min_dist = 999999;

	// Encontrar al obj_Player más cercano que NO SEA el mismo bot ni un bot equipo.
	with (obj_Player) {
	    if (hp > 0 && id != other.id) {
	        var _d = point_distance(x, y, other.x, other.y);
	        if (_d < _min_dist) {
	            _min_dist = _d;
	            _target = id;
	        }
	    }
	}
	var _dist = point_distance(x, y, _target.x, _target.y);
    var _dir = point_direction(x, y, _target.x, _target.y);
    var _angle = (angle_difference(image_angle, _dir) -  (-180)) / (180 - (-180)); // Ángulo
	
draw_set_color(c_black);
draw_text(_xx, _yy, "Angulo: " + string(_angle));
draw_text(_xx, _yy+10, "Objetivo: " + string(_target));


