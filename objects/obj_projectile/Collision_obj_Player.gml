if (variable_instance_exists(id, "owner") && owner != other.id) {
    if (other.state == "shield") {
        other.shield_ -= 10;
    } else {
        other.hp -= 10; 
    }
    instance_destroy(); 
}