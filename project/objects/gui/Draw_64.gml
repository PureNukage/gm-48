/// Draw stats
switch (room) {
    case room1 :
	
	        draw_set_halign(fa_center);
	        draw_set_font(fnt_title);
	        draw_text_colour(room_width/2+4, 32+6, "the\ntower", c_black, c_black, c_black, c_black, 1);
	        draw_text_colour(room_width/2, 32, "the\ntower", c_white, c_white, c_white, c_white, 1);
	        var start = keyboard_check_pressed(vk_space);

			if (gamepad_is_connected (0)) {
				start = gamepad_button_check_pressed(0,gp_start);
    
				}
    
			if (start == true && room = room1) {
				room_goto(room0);
    
			}

	        var str;
	        if (gamepad_is_connected(0)) {
	            str = "Press [Start] to Play";
	        } else {
	            str = "Press [Space] to Play";
            
	        }
        
	        draw_set_font(fnt_start);
	        draw_text_colour(room_width/2+2, room_height-44, str, c_black, c_black, c_black, c_black, 1);
	        draw_text_colour(room_width/2, room_height-48, str, c_white, c_white, c_white,c_white, 1); 
			
			draw_set_font(-1)
        break;
        
    default:
			
    break;
}