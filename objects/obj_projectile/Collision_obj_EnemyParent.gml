if (variable_instance_exists(id, "owner") && owner != other.id) {
    
    // 2. DETECTAR SI EL ENEMIGO SE ESTÁ PROTEGIENDO
    var _esta_bloqueando = false;
    
    if (variable_instance_exists(other, "input_shield") && other.input_shield) {
        if (variable_instance_exists(other, "shield_") && other.shield_ > 0) {
            _esta_bloqueando = true;
        }
    }
    
    if (_esta_bloqueando) {
        // SI BLOQUEA -> Dañar el escudo
        other.shield_ -= 20; 
    } 
    else {
        other.hp -= 20; 
    }
    
    // 4. Destruir la bala
    instance_destroy();
}