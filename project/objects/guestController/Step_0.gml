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
		for(var i=0;i<ds_list_size(door_list);i++) {
			guest_list[| i] = door_list[| i]
			for(var f=0;f<ds_list_size(floors_list);f++) {
				if floors_list[| f] == door_list[| i].y+sprite_height {
					door_list[| i].Floor = f
				}
			}
		}
	
		//	Assign Floors to elevators
		for(var elev=0;elev<ds_list_size(elevator_list);elev++) {
			var _elevator = elevator_list[| elev]
			var elevators_floor_y = _elevator.floors_y[_elevator.current_floor]-64
			var elevators_floor = ds_list_find_index(floors_list,elevators_floor_y)
			if elevators_floor != -1 {
				_elevator.Floor = elevators_floor	
			}			
		}
	
		//	Assign Floor to player
		player.Floor = ds_list_find_index(floors_list,player.y)
	
		//	Debug
		for(var d=0;d<ds_list_size(floors_list);d++) {
			show_debug_message("floor: " + string(d) + " is at: " + string(floors_list[| d]))
		}
	}
	
#endregion

else {

	#region Spawn guest(s)
	
		var total_guests = 1
	
		if instance_number(guest) < total_guests {
		
			var _random = irandom_range(0,ds_list_size(door_list)-1)
			var _random2 = irandom_range(0,ds_list_size(door_list)-1)
		
			var which_room = door_list[| _random]
		
			var _guest = instance_create_layer(which_room.x,which_room.y,"Instances_controller",guest)
		
			_guest.Floor = door_list[| _random].Floor
			_guest.DoorID = _random
			_guest.DoorGID = door_list[| _random]
		
			ds_stack_push(_guest.goal_queue,door_list[| _random2])
		}
		
	#endregion
	
}