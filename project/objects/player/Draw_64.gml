//	Draw the Gest / Door ratio
if instance_exists(guestController) {
	var guest_count = ds_list_size(guestController.guest_list)
	var door_count = ds_list_size(guestController.door_list)
	
	draw_text(display_get_gui_width()/2,64,string(guest_count)+" / "+string(door_count))
}