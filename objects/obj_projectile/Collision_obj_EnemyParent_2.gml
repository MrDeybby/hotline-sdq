// Asegurarnos de que la bala sepa de qué equipo es
if (!variable_instance_exists(id, "team")) exit;

if (variable_instance_exists(id, "owner") && owner != other.id && team != other.team) {
    
    if (variable_instance_exists(other, "state") && other.state == "shield") {
        other.shield_ -= 20; 
    } 
    else {
        other.hp -= 10;    
		

    }
	
	// RECOMPENSAR AL AGENTE (IA)
	if (owner.object_index == obj_AiPlayer) {
	    owner.damage_dealt += 10; 
		
		if other.hp <= 0{
			owner.total_deaths += 1
			//show_debug_message("Mato uno")
		}
	}
	
    instance_destroy();
}