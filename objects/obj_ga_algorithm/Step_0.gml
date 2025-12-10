    // Reiniciar generación
    if (instance_number(obj_AiPlayer) <= 0 or ((instance_number(obj_AiPlayer) + instance_number(obj_EnemyParent_2)) <= 6)) {
        
		with (obj_AiPlayer)
		{
			instance_destroy()
		}
		
		next_gen();
		
		
    }