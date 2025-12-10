// Chequeo muerte
if (hp <= 0) {
    instance_destroy(); 
    exit;
}

// Fitness
time_alive++;

frames_alive++



input_melee = false;
input_shield = false;
input_shoot = false;
input_shield = false;
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
for(var i=0; i<array_length(_outputs_matrix); i++) {
    array_push(_outputs_array, _outputs_matrix[i][0]);
}

var index_neuron = argmax(_outputs_array)
var recommended_state = state_names[index_neuron];


var segundos = time_alive / room_speed;

if (frames_alive >= 10) {
    
    // Solo cambiar si el nuevo es diferente
	
    if (recommended_state != currentState) {
        currentState = recommended_state;
    }	
    
    frames_alive = 0; // Reiniciar cooldown después de permitir cambio
}

if log_stats and segundos >= counter {
	
		show_debug_message(_outputs_array)	
		show_debug_message(index_neuron)	
		counter += 2
	}



// Heredar físicas
event_inherited();
