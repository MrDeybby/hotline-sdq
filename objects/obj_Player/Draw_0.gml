draw_self();

if (state == "shield") {
    draw_set_alpha(0.5);
    draw_set_color(c_aqua); 
    draw_circle(x, y, 40, false); 

    draw_set_alpha(1);
    draw_set_color(c_white); 
}