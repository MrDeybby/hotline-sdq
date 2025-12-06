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

// Movimiento (-1 a 1)
var _move_x_raw = _outputs_matrix[0][0];
var _move_y_raw = _outputs_matrix[1][0];
input_x = (_move_x_raw * 2) - 1; 
input_y = (_move_y_raw * 2) - 1;

// Apuntado
var _aim_x = (_outputs_matrix[2][0] * 2) - 1;
var _aim_y = (_outputs_matrix[3][0] * 2) - 1;
if (_aim_x != 0 || _aim_y != 0) {
    input_aim_dir = point_direction(0, 0, _aim_x, _aim_y);
}

// Disparo
input_shoot = (_outputs_matrix[4][0] > 0.5);

// Acciones especiales
var _action_val = _outputs_matrix[5][0];
input_melee = (_action_val > 0.33 && _action_val <= 0.66);
input_shield = (_action_val > 0.66);

// Heredar físicas
event_inherited();