// 1. Safety check
if (!variable_instance_exists(id, "team")) exit;

// 2. Condición con Equipos
if (variable_instance_exists(id, "owner") && owner != other.id && team != other.team) {
    
    if (other.state == "shield") {
         other.shield_ -= 2;
    } else {
         other.hp -= 2; 
    }
    

}