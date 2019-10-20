switch(mode)
{
	case 2:
		draw_set_color(c_white)
		
		draw_set_halign(fa_left)
		draw_text(15,15,"frames: "+string(time.frames))
		draw_text(15,30,"seconds: "+string(time.seconds))
		draw_text(15,45,"minutes: "+string(time.minutes))
		draw_text(15,60,"total guests: "+string(ds_list_size(guestController.guest_list)))
		draw_text(15,75,"total active guests: "+string(ds_list_size(guestController.guest_active_list)))
		draw_text(15,90,"total indoors guests: "+string(ds_list_size(guestController.guest_indoors_list)))
	break
}