    // Reiniciar generación
    if (instance_number(obj_AiPlayer) <= 0 or ((instance_number(obj_AiPlayer) + instance_number(obj_EnemyParent_2)) <= 6)) {
        
		if n_bots == 1{
			exit;	
		}
		with (obj_AiPlayer)
		{
			time_alive = max_seconds_alives
			instance_destroy()
		}
		
		next_gen();
		
		
    }