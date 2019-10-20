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
			guest_list[| i] = -1
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
			show_debug_message("["+string(time.stream)+"] floor: " + string(d) + " is at: " + string(floors_list[| d]))
		}
	}
	
#endregion

else if time.stream > 1 {

	#region Spawn guest(s)
	
		if instance_number(guest) < guest_total {
		
			var _random_assigned_door = irandom_range(0,ds_list_size(door_list)-1)
			var _random_goal_door = irandom_range(0,ds_list_size(door_list)-1)
			
			while _random_goal_door == _random_assigned_door _random_goal_door = irandom_range(0,ds_list_size(door_list)-1)
		
			var which_door = door_list[| _random_assigned_door]
		
			var _guest = instance_create_layer(which_door.x,which_door.y,"Instances_controller",guest)
		
			debug_log("which door GID: "+string(which_door))
			debug_log("door assigned floor: "+string(which_door.Floor))
			_guest.Floor = which_door.Floor
			_guest.DoorID = _random_assigned_door
			_guest.DoorGID = door_list[| _random_assigned_door]
		
			ds_stack_push(_guest.goal_queue,door_list[| _random_goal_door])
		}
		
	#endregion
	
}