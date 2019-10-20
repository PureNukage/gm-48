if ds_list_find_index(guestController.guest_list,id) != -1 {
	ds_list_delete(guestController.guest_list,ds_list_find_index(guestController.guest_list,id))	
}