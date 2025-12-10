// Configuración de la IA
global.nn_shooter_config = {
    "inputs": 10,    // Los 8 sensores que definimos
    "h1": 12,       // Capa oculta 1
    "h2": 8,        // Capa oculta 2
    "outputs": 6,
};

global.ga_config = {
	
	"n": 6,       // Población
    "mut": 80,     // Probabilidad mutación
    "select": 60,  // Porcentaje selección
	"time_alive": 20 // Segundos para matar la generacion actual
};
global.custom_gene = undefined;