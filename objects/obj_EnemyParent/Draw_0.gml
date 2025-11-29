// 1. DIBUJAR AL PERSONAJE
draw_self();

// 2. CONFIGURACIÓN DE LAS BARRAS
var _bar_width = 32;  // Ancho de la barra en pixeles
var _bar_height = 4;  // Alto de la barra
var _offset_y = 35;   // Qué tan arriba de la cabeza aparece

// Posiciones calculadas para que quede centrado sobre el enemigo
var _x1 = x - (_bar_width / 2);
var _x2 = x + (_bar_width / 2);
var _y_hp = y - _offset_y;

// 3. DIBUJAR BARRA DE VIDA (Verde/Roja)
// Solo la dibujamos si no está muerto
if (hp_ > 0) {
    var _hp_percent = (hp_ / max_hp) * 100;
    draw_healthbar(_x1, _y_hp, _x2, _y_hp + _bar_height, _hp_percent, c_black, c_red, c_lime, 0, true, true);
}

// 4. DIBUJAR BARRA DE ESCUDO (Azul)
// Solo la dibujamos si tiene algo de escudo
if (shield_ > 0) {
    var _shield_percent = (shield_ / max_shield) * 100;
    var _y_shield = _y_hp - 6; 
    
    draw_healthbar(_x1, _y_shield, _x2, _y_shield + _bar_height, _shield_percent, c_black, c_dkgray, c_aqua, 0, true, true);
}