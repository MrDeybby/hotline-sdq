// Verificamos que exista el dueño y que no nos estemos disparando a nosotros mismos
if (variable_instance_exists(id, "owner") && owner != other.id) {
    
    // 1. APLICAR DAÑO (Usando la variable 'damage' del proyectil)
    if (other.state == "shield") {
        other.shield_ -= damage; // Restar al escudo
    } else {
        other.hp -= damage;     // Restar a la vida ojo: hp_ con guion bajo)
    }

    // 2. RECOMPENSAR AL AGENTE (IA)
    // Si el dueño del disparo existe y es un Bot, le sumamos puntos
    if (instance_exists(owner) && owner.object_index == obj_Bot) {
        owner.damage_dealt += damage; 
        owner.shots_hit += 1; // Opcional: contar balas acertadas para estadísticas
    }

    // 3. DESTRUIR PROYECTIL
    instance_destroy(); 
}
