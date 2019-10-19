#region First frame of the game
if time.stream == 1 {

	floors_list = ds_list_create()
	//	How many floors do we have
	for(var c=0;c<ds_list_size(elevator_list);c++) {
	
		with elevator_list[| c] {
			for(var a=0;a<floors;a++) {
			
				if ds_list_find_index(other.floors_list,floors_y[a]-64) == -1 {
					ds_list_add(other.floors_list,floors_y[a]-64)
				}
			
			}
		}
	}

	ds_list_sort(floors_list,false)	
	
	//	How many guests we got and assign floors to doors
	for(var i=0;i<ds_list_size(room_list);i++) {
		guest_list[| i] = room_list[| i]
		for(var f=0;f<ds_list_size(floors_list);f++) {
			if floors_list[| f] == room_list[| i].y+sprite_height {
				room_list[| i].Floor = f
			}
		}
	}
	
	//	Debug
	for(var d=0;d<ds_list_size(floors_list);d++) {
		show_debug_message("floor: " + string(d) + " is at: " + string(floors_list[| d]))
	}
}
#endregion

else {
	
	var total_guests = 8
	
	if instance_number(guest) < total_guests {
		
		var which_room = room_list[| irandom_range(0,ds_list_size(room_list)-1)]
		
		var _guest = instance_create_layer(which_room.x,which_room.y,"Instances_controller",guest)
	}
	
	
	
	
	
	
	
	
}