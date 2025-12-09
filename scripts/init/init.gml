// Configuración de la IA
global.nn_shooter_config = {
    "inputs": 8,    // Los 8 sensores que definimos
    "h1": 12,       // Capa oculta 1
    "h2": 8,        // Capa oculta 2
    "outputs": 6,   // Salidas: MovX, MovY, MiraX, MiraY, Disparo, Accion(Melee/Shield)
    "time_alive": 15 // Segundos límite si no hace nada interesante
};

global.ga_config = {
	
	"n": 1,       // Población
    "mut": 40,     // Probabilidad mutación
    "select": 60,  // Porcentaje selección
	"time_alive": 20 // Segundos para matar la generacion actual
};
global.custom_gene = undefined;