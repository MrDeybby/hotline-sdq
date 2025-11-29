// 1. Resetear inputs
input_x = 0;
input_y = 0;
//input_melee = false;
//input_shoot = false;
//input_shield = false;

// 2. Comprobar si existe el jugador
if (instance_exists(obj_Human)) {
    var _player = instance_nearest(x, y, obj_Human);
    var _dist = point_distance(x, y, _player.x, _player.y);
    
    // Lógica Genérica: Calcular ruta hacia el objetivo actual
    // (Por defecto el objetivo es donde esté parado él mismo, los hijos cambiarán esto)
    if (mp_grid_path(global.mp_grid, path, x, y, target_x, target_y, true)) {
        
        // Empezar a seguir el camino calculado
        // path_start(path, run_spd, path_action_stop, false); 
        // Nota: path_start a veces entra en conflicto con nuestras físicas manuales.
        // Vamos a usar un método más manual para controlar input_x/y:
        
        var _next_x = path_get_point_x(path, 1); // El siguiente punto en la ruta
        var _next_y = path_get_point_y(path, 1);
        
        // Si hay un camino válido, nos movemos hacia el siguiente punto
        if (_next_x != 0 && _next_y != 0) {
            var _dir = point_direction(x, y, _next_x, _next_y);
            input_x = lengthdir_x(1, _dir); // Simular joystick (-1 a 1)
            input_y = lengthdir_y(1, _dir);
            
            // Mirar hacia donde vamos
            input_aim_dir = _dir;
        }
    }
}

// 3. Ejecutar Físicas del Padre (Moverse real)
event_inherited();