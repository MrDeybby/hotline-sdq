
	
if instance_exists(obj_ga_algorithm){
	
	var _w1 = global.ga_config[$"w1"];
	var _w2 = global.ga_config[$"w2"];
	var _w3 = global.ga_config[$"w3"];
	var _w4 = global.ga_config[$"w4"];
	
	var new_fitness = get_fitness(_w1, _w2, _w3, _w4);
	if new_fitness > fitness{
		fitness = new_fitness	
	}
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