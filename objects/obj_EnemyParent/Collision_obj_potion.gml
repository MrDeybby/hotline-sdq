if (hp < max_hp) {
    hp += 50;
    if (hp > max_hp) hp = max_hp;
    instance_destroy(other);
}