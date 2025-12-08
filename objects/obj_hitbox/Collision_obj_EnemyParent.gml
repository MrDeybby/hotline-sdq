// Asegurarnos de que el hitbox sepa de qué equipo es
if (!variable_instance_exists(id, "team")) exit;

if (variable_instance_exists(id, "owner") && owner != other.id && team != other.team) {
    
    // Si el enemigo se está cubriendo con escudo
    if (variable_instance_exists(other, "state") && other.state == "shield") {
        other.shield_ -= 2;
    } 
    else {
        other.hp -= 2;      
    }
}