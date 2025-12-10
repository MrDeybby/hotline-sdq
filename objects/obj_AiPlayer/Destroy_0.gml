// Calcular fitness




if log_stats {
		show_debug_message("state_changes: " + string(state_changes));
	}
	
if instance_exists(obj_ga_algorithm){
	//fitness = time_alive/room_speed + (damage_dealt * 10) + hp; 
	fitness = get_fitness();
}
// Exportar genes
if (instance_exists(neural_network) && instance_exists(obj_ga_algorithm)) {
    var _genes = neural_network.get_genes(); 
    
    var _dna = {
        "weights": _genes.weights,
        "biases": _genes.biases,
        "fitness": fitness,
        "hue": image_blend 
    };
    
    // Guardar en manager
    ds_list_add(obj_ga_algorithm.genes, _dna); 
    instance_destroy(neural_network);
}