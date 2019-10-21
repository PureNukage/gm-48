//	Draw the Gest / Door ratio
if instance_exists(guestController) {
	
	draw_set_halign(fa_center)
	draw_set_color(c_white)
	var guest_count = ds_list_size(guestController.guest_list)
	var door_count = ds_list_size(guestController.door_list)
	
	draw_text(display_get_gui_width()/2,64,string(guest_count)+" / "+string(door_count))
	draw_set_halign(fa_left)
}