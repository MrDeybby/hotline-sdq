draw_self();

var left = bbox_left;
var right = bbox_right;
var bottom = bbox_bottom;
var top = bbox_top;

draw_set_colour(c_purple);
draw_set_alpha(0.4);
draw_rectangle(left, top, right, bottom, false);


if (state == "shield") {
    draw_set_alpha(0.5);
    draw_set_color(c_aqua); 
    draw_circle(x, y, 40, false); 

    draw_set_alpha(1);
    draw_set_color(c_white); 
}