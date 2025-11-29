// Solo curar si no tiene la vida llena
if (hp_ < max_hp) {
    hp_ += 5;  
    
    // Limitar la vida al máximo
    if (hp_ > max_hp) hp_ = max_hp;
    
    // Destruir la pócima
    with (other) {
        instance_destroy();
    }
}