// Estructura red
net = {
    weights: [],
    biases: [],
    activations: []     
};

// Inicializar red
function init_network(_layer_sizes) {
    // Limpiar
    net.weights = [];
    net.biases = [];
    
    // Matrices aleatorias
    for (var _i = 1; _i < array_length(_layer_sizes); _i++) {
        var _rows = _layer_sizes[_i];
        var _cols = _layer_sizes[_i - 1];
        
        var _w = create_random_matrix(_rows, _cols);
        var _b = create_random_matrix(_rows, 1);
        
        array_push(net.weights, _w);
        array_push(net.biases, _b);
    }
}

// ReLU (Ocultas)
function relu(_x_matrix) {
    return _matrix_map(_x_matrix, function(_v) { return max(0, _v); });
}

// Sigmoide (Salida)
function sigmoid(_x_matrix) {
    return _matrix_map(_x_matrix, function(_v) { return 1 / (1 + exp(-_v)); });
}

// Feed Forward
function evaluate_network_2(_input_vec, _hidden_act_fn=relu, _output_act_fn=sigmoid) {
    // Protección
    if (array_length(net.weights) == 0) return [[0]];
    
    var _a = _input_vec;
    
    // Calcular capas
    for (var _i = 0; _i < array_length(net.weights); _i++) {
        var _weighted_sum = _matrix_multiply(net.weights[_i], _a);
        var _z = _matrix_sum(_weighted_sum, net.biases[_i]);
        
        // Activación
        if (_i == array_length(net.weights) - 1) {
            _a = _output_act_fn(_z); // Salida
        } else {
            _a = _hidden_act_fn(_z); // Ocultas
        }
    }
    return _a;
}

// Obtener genes
function get_genes() {
    return { weights: net.weights, biases: net.biases };
}

// Asignar genes
function set_genes(_gene_struct) {
    net.weights = _gene_struct.weights; 
    net.biases = _gene_struct.biases;
}