// Configuración de la IA
global.nn_shooter_config = {
    "inputs": 10,        // Sensores
    "hidden_layers": [2, 3], // Capas cultas
    "outputs": 6,        // Salidas
};

global.ga_config = {
	
	"n": 6,       // Población
    "mut": 80,     // Probabilidad mutación
    "select": 60,  // Porcentaje selección
	"time_alive": 20 // Segundos para matar la generacion actual
};
global.custom_gene = undefined;