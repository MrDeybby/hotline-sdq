// Configuración de fuente (Opcional, para asegurar que se lea bien)
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// ----------------------------------------------------
// 1. BARRA DE VIDA
// ----------------------------------------------------
// Calculamos el porcentaje (0 a 100) para la barra
var _hp_pc = (hp / max_hp) * 100; 

// Dibujar barra (x1, y1, x2, y2, valor, fondo, min_col, max_col, dir, show_back, show_border)
draw_healthbar(20, 20, 220, 40, _hp_pc, c_black, c_red, c_lime, 0, true, true);

// Texto descriptivo a la derecha de la barra
draw_set_color(c_black); // Usamos blanco para que se lea sobre cualquier fondo
draw_text(230, 20, "VIDA: " + string(floor(hp)) + "/" + string(max_hp));


// ----------------------------------------------------
// 2. BARRA DE ESCUDO
// ----------------------------------------------------
var _sh_pc = (shield_ / max_shield) * 100;

draw_healthbar(20, 50, 220, 70, _sh_pc, c_black, c_dkgray, c_aqua, 0, true, true);
draw_text(230, 50, "ESCUDO: " + string(floor(shield_)));


// ----------------------------------------------------
// 3. SISTEMA DE MUNICIÓN
// ----------------------------------------------------
// Verificamos si estamos recargando (asumiendo que definiste estas variables en el Create)

// Si la variable is_reloading existe y es verdadera
if (variable_instance_exists(id, "is_reloading") && is_reloading) {
    draw_set_color(c_red);
    draw_text(20, 80, "RECARGANDO... (3s)");
} 
else {
    // Si no estamos recargando, mostramos balas
    draw_set_color(c_black);
    
    // Verificamos que las variables existan para evitar crash si aún no programaste las armas
    var _curr = variable_instance_exists(id, "current_ammo") ? string(current_ammo) : "?";
    var _max  = variable_instance_exists(id, "max_ammo") ? string(max_ammo) : "?";
    
    draw_text(20, 80, "BALAS: " + _curr + " / " + _max);
}

// Resetear color al final
draw_set_color(c_white);