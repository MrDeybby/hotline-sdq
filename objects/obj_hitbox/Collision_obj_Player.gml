if (variable_instance_exists(id, "owner") && owner != other.id) {
    if (other.state == "shield") {
         other.shield_ -= 2;
    } else {
         other.hp -= 2; 
    }
}