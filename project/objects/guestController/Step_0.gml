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
	
		if instance_number(guest) < guests_starting {
			
			var _guest = spawn_guest()
			if _guest != -1 {
				
				//	Let's send him somewhere random either above him or under him or on his floor

				var above_under_same = irandom_range(-1,1)
				var hypothetical_new_floor = _guest.Floor + above_under_same
				if hypothetical_new_floor > 0 and hypothetical_new_floor < ds_list_size(floors_list)-1 {
					var _floor = hypothetical_new_floor
				} else {
					var _floor = _guest.Floor
				}
				
				var _x = irandom_range(_guest.x-164,_guest.x+164)
				while (_x < 0 or _x > room_width) _x = irandom_range(_guest.x-164,_guest.x+164)
				
				var _goalpost = instance_create_layer(_x,floors_list[| _floor],"Instances_controller",goalpost)
				
				_goalpost.Floor = _floor
				_goalpost.goal_type = goal_type.do_something
				
				_guest.goal = _goalpost
				ds_stack_push(_guest.goal_queue,_goalpost)
				
			}
		}
		
	#endregion
	
	#region	Give a guest a task
		
		var guests_total = ds_list_size(guest_list)
		var active_guests_total = ds_list_size(guest_active_list)
		var indoors_guests_total = ds_list_size(guest_indoors_list)
		if guests_total > 0 and indoors_guests_total > 0 and active_guests_total < guests_active_clamp {
			debug_log("I am giving a Guest a task")
			
				var _random
				if ds_list_size(guest_indoors_list) == 1 _random = 0
				else _random = irandom_range(0,ds_list_size(guest_indoors_list)-1)
				var _guest = ds_list_find_value(guest_indoors_list,_random) 
			
				//	Let's send him somewhere random either above him or under him or on his floor

				var above_under_same = irandom_range(-1,1)
				var hypothetical_new_floor = _guest.Floor - above_under_same
				if hypothetical_new_floor == 1 {
					var _floor = 1 
				} else if hypothetical_new_floor >= 0 and hypothetical_new_floor < ds_list_size(floors_list)-1 {
					var _floor = hypothetical_new_floor
				} else {
					var _floor = _guest.Floor
				}
				
				var _x = irandom_range(_guest.x-164,_guest.x+164)
				while (_x < 0 or _x > room_width) _x = irandom_range(_guest.x-164,_guest.x+164)
				
				var _goalpost = instance_create_layer(_x,floors_list[| _floor],"Instances_controller",goalpost)
				
				_goalpost.Floor = _floor
				_goalpost.goal_type = goal_type.do_something
				
				//	Deal with guests lists
				ds_list_add(guest_active_list,_guest)
				ds_list_delete(guest_indoors_list,ds_list_find_index(guest_indoors_list,_guest))	
				
				_guest.goal = _goalpost
				ds_stack_push(_guest.goal_queue,_goalpost)
				_guest.states = states.idle
				_guest.image_alpha = 1
			
		}
	
	
	
	#endregion
	
}