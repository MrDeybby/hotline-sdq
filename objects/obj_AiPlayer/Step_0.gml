// Chequeo muerte
if (hp <= 0) {
    instance_destroy(); 
    exit;
}

// Fitness
time_alive++;

// Obtener sensores
var _inputs_matrix = [];
var _sensor_data = get_sensors();

// Convertir a matriz
for(var i=0; i<array_length(_sensor_data); i++) {
    array_push(_inputs_matrix, [_sensor_data[i]]);
}
last_inputs = _sensor_data; 

// Feed Forward
var _outputs_matrix = neural_network.evaluate_network_2(_inputs_matrix);

var _outputs_array = [];

// Convertir a arreglo de 1 dimension
for(var i=0; i<array_length(_outputs_matrix[0]); i++) {
    array_push(_outputs_array, [_outputs_matrix[0][i]]);
}

index_neuron = argmax(_outputs_array)
currentState = state_names[index_neuron];
show_debug_message("Index: "+ string(index_neuron) + "State: " + string(currentState))
// Heredar físicas
event_inherited();