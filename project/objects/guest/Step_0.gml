switch(states)
{
	#region Idle
		case states.idle:
	
		#region	I got something to do!	
			show_debug_message("["+string(time.stream)+"] I got something to do!")
			if ds_stack_size(goal_queue) > 0 {
		
				goal = ds_stack_top(goal_queue)
		
				// Is my goal above me, under me or on the same floor?
				var vDirection = sign(Floor - goal.Floor)
		
				switch(vDirection)
				{
					case -1:	//	My goal is above me
					case 1:		//	My goal is under me
				
					show_debug_message("["+string(time.stream)+"] My goal is above or under me!")
					#region Elevator check
				
						#region	Lets check if any elevators are on this floor
							for(var elev=0;elev<ds_list_size(guestController.elevator_list);elev++) {
								var _elevator = guestController.elevator_list[| elev]
								var elevators_on_this_floor = ds_list_create()
						
								//	This elevators on the same floor as us!
								if _elevator.Floor == Floor {	
									show_debug_message("["+string(time.stream)+"] Elevator "+string(_elevator)+" is on the same floor as me")								
									ds_list_add(elevators_on_this_floor,_elevator.id)
								}
							}
						#endregion
				
						#region	We have an elevator on our floor		
					
							if ds_list_size(elevators_on_this_floor) > 0 {
								var how_many = ds_list_size(elevators_on_this_floor)
								
								debug_log("There are "+string(how_many)+" elevators on my floor")	
								
								#region	Sort elevators into closest -> furthest
									var distance_list = ds_list_create()						
									for(var elv=0;elv<how_many;elv++) {
							
										//	Distance between guest and elevator
										var distance = abs(elevators_on_this_floor[| elv].x - x)
										debug_log("Elevator "+string(elevators_on_this_floor[| elv])+" is "+string(distance)+" away from me")
										ds_list_add(distance_list,distance)
									}
							
									//	Copy this list and then sort it
									var distance_list_sorted = ds_list_create()
									ds_list_copy(distance_list_sorted,distance_list)
									ds_list_sort(distance_list_sorted,true)
						
								#endregion
							
								#region	Make this elevator our goal and head into the walk state
						
									var closest_elevator_distance = distance_list_sorted[| 0]
									var closest_elevator_before_sorting = ds_list_find_index(distance_list,closest_elevator_distance)
									var closest_elevator = elevators_on_this_floor[| closest_elevator_before_sorting]
							
									ds_stack_push(goal_queue,closest_elevator)
									goal = closest_elevator
						
									var which_side_of_elevator = 0
									var which_side_of_elevator_raw = sign(closest_elevator.x - x)
									if which_side_of_elevator_raw == -1 which_side_of_elevator = 1
									else which_side_of_elevator = 0
									
									debug_log("moving towards goal! name: "+string(object_get_name(goal.object_index))+" , GID: "+string(goal))
									debug_log("taking the "+string(which_side_of_elevator)+" elevator shaft")
									
									goalX = goal.shaft[which_side_of_elevator]
									Direction = sign(goalX - x)
									goalX += sign(Direction)*-31
									debug_log("goalX "+string(goalX))									
									debug_log("direction: "+string(Direction))
						
									states = states.walk
						
								#endregion				
					
							} 
				
						#endregion		
					
						#region No elevators on this floor
							else {

							}
						#endregion
					
					#endregion
				
					break;
					case 0:		//	My goal is on the same floor as me
					debug_log("My goal is on the same floor as me")
			
					break;
				}
			
			}
		
		#endregion
	
		break
	#endregion
	#region Walk
		case states.walk:
			
			hspd += Direction*movespeed
			
			hspd = clamp(hspd,-movespeed,movespeed)
			
			//	Apply horizontal thrust while collision checking each pixel movement
			repeat(abs(hspd)) {
				var next_pixel = x + sign(hspd)
				if next_pixel != goalX {
					x += sign(hspd)	
				} else { 
					hspd = 0
				}	
			}
	
	
		break
	#endregion
}