switch(mode)
{
	case 0:
		if instance_exists(player) {
			x = player.x
			y = player.y
		}
		
		if mouse_check_button_pressed(mb_right) {
			mode = 1
			x_offset = mouse_x - x
			y_offset = mouse_y - y
		}
	break;
	case 1:
	
		x = mouse_x - x_offset
		y = mouse_y - y_offset
		
		if mouse_check_button_pressed(mb_right) {
			mode = 0	
		}
	break;
	
}