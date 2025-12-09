// 1. IMPORTANTE: Verificamos que la bala sepa de qué equipo es (Safety check)
if (!variable_instance_exists(id, "team")) exit; 

// 2. LA CONDICIÓN MAESTRA
if (variable_instance_exists(id, "owner") && owner != other.id && team != other.team) {
    
    // APLICAR DAÑO
    if (other.state == "shield") {
        other.shield_ -= damage; 
    } else {
        other.hp -= damage;    
		
		
    }

   

    // DESTRUIR
    instance_destroy(); 
}