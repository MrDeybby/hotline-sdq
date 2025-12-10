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
	"time_alive": 20, // Segundos para matar la generacion actual
	"w1": 0.5, // Tiempo de vida
	"w2": 1, // Kills
	"w3": 0.75, // Daño hecho
	"w4": 0.6, // Vida que le quitaron
};
// undefined;
global.custom_gene = { weights : [ [ [ -1,0.89,-0.10,0.25,-0.27,-1,0.23,-1,-0.56,0.50 ],[ -1,-0.03,0.28,0.30,0.40,-0.34,-0.38,-0.78,1,0.01 ] ],[ [ 0.19,0.19 ],[ 0.77,0.47 ],[ 0.74,0.22 ] ],[ [ 0.28,-0.96,-0.35 ],[ -0.99,1,0.22 ],[ 1,-0.70,-0.41 ],[ 0.90,0.52,1 ],[ -0.93,-0.60,-0.24 ],[ -1,-0.15,0.39 ] ] ], fitness : 1.31, hue : 3618815, biases : [ [ [ -0.50 ],[ -0.04 ] ],[ [ 0.09 ],[ 0.75 ],[ -0.52 ] ],[ [ -0.56 ],[ 1 ],[ -0.11 ],[ 1 ],[ -1 ],[ -0.70 ] ] ] }