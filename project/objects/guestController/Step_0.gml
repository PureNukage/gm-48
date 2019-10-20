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
		
		//	Copy door list and make vacancy list
		ds_list_copy(vacancy_list,door_list)
	
		//	How many guests we got and assign floors to doors
		for(var i=0;i<ds_list_size(door_list);i++) {
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
			
			var _guest = spawn_guest()
			if _guest != -1 {
				
				if ds_list_size(guestController.vacancy_list) == 1 {
					var _random = 0	
				} else {
					var _random = irandom_range(0,ds_list_size(guestController.vacancy_list)-1)	
				}
										
				var new_door = guestController.vacancy_list[| _random]
				ds_stack_push(_guest.goal_queue,new_door)
				ds_list_delete(guestController.vacancy_list,_random)
			}
		}
		
	#endregion
	
}