// Asegurarnos de que la bala sepa de qué equipo es
if (!variable_instance_exists(id, "team")) exit;

if (variable_instance_exists(id, "owner") && owner != other.id && team != other.team) {
    
    if (variable_instance_exists(other, "state") && other.state == "shield") {
        other.shield_ -= 20; 
    } 
    else {
        other.hp -= 20;    
    }

    instance_destroy();
}