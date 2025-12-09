// Inherit the parent event
event_inherited();
// Gestión Muerte / Nivel
if (hp <= 0) {
    // Siguiente nivel (si es último)
    if (instance_number(obj_EnemyParent_2) <= 1) {
        
        switch (room) {
            case rm_AILevel1_A: room_goto(rm_AILevel1_B); break;
            case rm_AILevel1_B: room_goto(rm_AILevel1_C); break;
            case rm_AILevel1_C: room_goto(rm_AILevel2_A); break; 
            
            case rm_AILevel2_A: room_goto(rm_AILevel2_B); break; 
            case rm_AILevel2_B: room_goto(rm_AILevel2_C); break; 
            case rm_AILevel2_C: room_goto(rm_AILevel3_A); break; 
            
            case rm_AILevel3_A: room_goto(rm_AILevel3_B); break;
            case rm_AILevel3_B: room_goto(rm_AILevel3_C); break;
            case rm_AILevel3_C: room_goto(rm_AILevel4);   break;
            
            case rm_AILevel4:   room_goto(rm_menu_main); break;
            
            case rm_Level1: room_goto(rm_Level2); break;
            case rm_Level2: room_goto(rm_Level3); break;
            case rm_Level3: room_goto(rm_Level4); break;
            case rm_Level4: room_goto(rm_menu_main); break;
            
            default: room_goto(rm_menu_main); break;
        }
    }
    
    // Destruir
    instance_destroy();
}

