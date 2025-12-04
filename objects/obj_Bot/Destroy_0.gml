// Calcular fitness
fitness = time_alive + (damage_dealt * 10); 

if (level_completed) fitness += 2000; 

// Exportar genes
if (instance_exists(neural_network) && instance_exists(obj_genetic_algorithm)) {
    var _genes = neural_network.get_genes(); 
    
    var _dna = {
        "weights": _genes.weights,
        "biases": _genes.biases,
        "fitness": fitness,
        "hue": image_blend 
    };
    
    // Guardar en manager
    ds_list_add(obj_genetic_algorithm.genes, _dna); 
    instance_destroy(neural_network);
}

// Notificar muerte
if (instance_exists(obj_genetic_algorithm)) {
    obj_genetic_algorithm.bots_alive--;
    
    // Reiniciar generación
    if (obj_genetic_algorithm.bots_alive <= 0) {
        obj_genetic_algorithm.next_gen();
    }
}