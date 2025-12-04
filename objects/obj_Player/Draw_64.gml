draw_set_color(c_black);

draw_text(20, 20, "VIDA: " + string(hp));
draw_healthbar(20, 40, 200, 50, hp, c_black, c_red, c_lime, 0, true, true);
draw_text(20, 60, "ESCUDO: " + string(shield_));
draw_healthbar(20, 80, 200, 90, shield_, c_black, c_gray, c_aqua, 0, true, true);

if (is_reloading) {
    draw_set_color(c_red);
    draw_text(20, 100, "RECARGANDO... (3s)");
} else {
    draw_set_color(c_black);
    draw_text(20, 100, "BALAS: " + string(current_ammo) + " / " + string(max_ammo));
}


