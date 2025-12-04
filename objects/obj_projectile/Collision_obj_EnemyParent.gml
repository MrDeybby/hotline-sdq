if (variable_instance_exists(id, "owner") && owner != other.id) {
    other.hp -= 20;
    instance_destroy();
}