// Asegurarnos de que el hitbox sepa de qué equipo es
if (!variable_instance_exists(id, "team")) exit;
if (!instance_exists(owner)) exit;

if (variable_instance_exists(id, "owner") && owner != other.id && team != other.team) {
    
    // Si el enemigo se está cubriendo con escudo
    if (variable_instance_exists(other, "state") && other.state == "shield") {
        other.shield_ -= 2;
    } 
    else {
        other.hp -= 2; 
    }
	
	// RECOMPENSAR AL AGENTE (IA)
	if (owner.object_index == obj_AiPlayer) {
	    owner.damage_dealt += 2; 
		
		if other.hp <= 0{
			owner.total_deaths += 1
			//show_debug_message("Mato uno")
		}
		//show_debug_message("Dio golpe")
	}
	
}