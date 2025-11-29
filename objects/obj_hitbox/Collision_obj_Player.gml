if (other.id != owner) {
    other.hp_ -= damage;
    instance_destroy(); // Desaparece tras golpear
}