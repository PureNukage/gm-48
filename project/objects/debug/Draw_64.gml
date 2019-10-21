switch(mode)
{
	case 2:
		draw_set_color(c_white)
		
		draw_set_halign(fa_left)
		with time {
			draw_text(15,15,"frames: "+string(frames))
			draw_text(15,30,"seconds: "+string(seconds))
			draw_text(15,45,"minutes: "+string(minutes))
		}
		with guestController {
			draw_text(15,60,"total guests: "+string(ds_list_size(guest_list)))
			draw_text(15,75,"total active guests: "+string(ds_list_size(guest_active_list)))
			draw_text(15,90,"total indoors guests: "+string(ds_list_size(guest_indoors_list)))
		
			draw_text(15,120,"total floors: "+string(ds_list_size(floors_list)))
		}
	break
}