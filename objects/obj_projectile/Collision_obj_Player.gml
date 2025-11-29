// "other" es el objeto con el que chocamos (el personaje)
// "owner" es la variable que guardamos de quién disparó la bala

// Si chocamos con alguien que NO es el dueño
if (other.id != owner) {
    other.hp_ -= damage; // Restar vida
    instance_destroy();  // Destruir la bala
}