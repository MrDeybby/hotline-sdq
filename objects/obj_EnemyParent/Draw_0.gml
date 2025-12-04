draw_self();
draw_healthbar(x-20, y-40, x+20, y-35, hp, c_black, c_red, c_lime, 0, true, true);

if (is_reloading) {
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_text(x, y - 60, "RECARGANDO...");
    draw_set_color(c_black);
    draw_set_halign(fa_left);
}