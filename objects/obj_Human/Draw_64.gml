// 1. DIBUJAR BARRA DE VIDA
var _hp_percent = (hp_ / max_hp) * 100;
draw_healthbar(20, 20, 220, 40, _hp_percent, c_black, c_red, c_lime, 0, true, true);

// Texto numérico de vida
draw_text(230, 20, "HP: " + string(hp_) + "/" + string(max_hp));


// 2. DIBUJAR BARRA DE ESCUDO (Azul)
var _shield_percent = (shield_ / max_shield) * 100;
draw_healthbar(20, 50, 220, 70, _shield_percent, c_black, c_dkgray, c_aqua, 0, true, true);

// Texto numérico de escudo
draw_text(230, 50, "ESCUDO: " + string(floor(shield_)));


// 3. DEBUG DEL ESTADO
draw_text(20, 90, "Estado: " + state);