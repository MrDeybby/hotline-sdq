event_inherited()
draw_self();
// Punto inicial (centro del enemigo)
var x1 = x;
var y1 = y;

// Convertir el ángulo a radianes
var ang = degtorad(image_angle);

var _target = noone;
	var _min_dist = 999999;

	// Encontrar al obj_Player más cercano que NO SEA el mismo bot ni un bot equipo.
	with (obj_Player) {
	    if (hp > 0 && id != other.id && team != other.team) {
	        var _d = point_distance(x, y, other.x, other.y);
	        if (_d < _min_dist) {
	            _min_dist = _d;
	            _target = id;
	        }
	    }
	}
	if (_target != noone) {
		var _dist = point_distance(x, y, _target.x, _target.y);
	    var _dir = point_direction(x, y, _target.x, _target.y);
	    var _angle = angle_difference(image_angle, _dir); // Ángulo

		// Punto final basado en el ángulo
		var x2 = x1 + lengthdir_x(_dist, _dir);
		var y2 = y1 + lengthdir_y(_dist, _dir);
		// Dibujar la línea
		draw_set_color(c_red);
		draw_line(x1, y1, x2, y2);
		
		
	}