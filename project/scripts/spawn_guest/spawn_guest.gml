var _guest = -1

//	Spawn a Guest
if ds_list_size(guestController.vacancy_list) > 0 {
	debug_log("Spawning a guest")
	if ds_list_size(guestController.vacancy_list) == 1 {
		debug_log("We had 1 vacancies")
		var _random = 0	
	} else {
		debug_log("We had "+string(ds_list_size(guestController.vacancy_list))+" vacancies")
		var _random = irandom_range(0,ds_list_size(guestController.vacancy_list)-1)	
	}
										
	var new_door = guestController.vacancy_list[| _random]
										
	debug_log("which door GID: "+string(new_door))
	debug_log("door assigned floor: "+string(new_door.Floor))
										
	_guest = instance_create_layer(new_door.x,new_door.y,"Instances_controller",guest)
	_guest.Floor = new_door.Floor
	_guest.DoorID = new_door.ID
	_guest.DoorGID = new_door
	
	new_door.vacant = false
	
	ds_list_delete(guestController.vacancy_list,_random)
										
	return _guest
							
} else {
	debug_log("Attempted to spawn guest but we have no vacancies!")	
	return _guest
}