// Calcular fitness
fitness = time_alive + (damage_dealt * 10); 

if (level_completed) fitness += 2000; 

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