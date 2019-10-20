switch(states)
{
	#region Idle
		case states.idle:
	
		#region	I got something to do!	
			if ds_stack_size(goal_queue) > 0 {
		
				debug_log("I have " +string(ds_stack_size(goal_queue)) + " goal to do!")
		
				goal = ds_stack_top(goal_queue)
		
				// Is my goal above me, under me or on the same floor?
				var vDirection = sign(Floor - goal.Floor)
		
				switch(vDirection)
				{
					case -1:	//	My goal is above me
					case 1:		//	My goal is under me
				
					debug_log("My goal is above or under me!")
					#region Elevator check
				
						#region	Lets check if any elevators are on this floor
							var elevators_on_this_floor = ds_list_create()						
							for(var elev=0;elev<ds_list_size(guestController.elevator_list);elev++) {
								var _elevator = guestController.elevator_list[| elev]
						
								//	This elevators on the same floor as us!
								if _elevator.Floor == Floor {	
									show_debug_message("["+string(time.stream)+"] Elevator "+string(_elevator)+" is on the same floor as me")								
									ds_list_add(elevators_on_this_floor,_elevator)
								}
							}
							
							var debug_elevators_on_this_floor_size = ds_list_size(elevators_on_this_floor)
							debug_log("There are "+string(debug_elevators_on_this_floor_size)+" elevators on my floor")
							
						#endregion
				
						#region	We have an elevator on our floor		
					
							if ds_list_size(elevators_on_this_floor) > 0 {
								var how_many = ds_list_size(elevators_on_this_floor)	
								
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
						goalX = goal.x
						Direction = sign(goalX - x)
						debug_log("goalX "+string(goalX))									
						debug_log("direction: "+string(Direction))
						states = states.walk
						
			
					break;
				}
			
			} else {
				debug_log("I got nothing to do!")	
			}
		
		#endregion
	
		break
	#endregion
	
	#region Walk
		case states.walk:
		
			#region If boarding elevator (LAZY FIX)
				if goal.object_index == goalpost and goal.goal_type == goal_type.elevator_board {
					if ds_list_find_index(goal.elevator.passenger_list,id) == -1 {
						ds_list_add(goal.elevator.passenger_list,id)	
					}
				}
				
			#endregion
			
			hspd += Direction*movespeed
			
			hspd = clamp(hspd,-movespeed,movespeed)
			
			//	Apply horizontal thrust while collision checking each pixel movement
			repeat(abs(hspd)) {
				var next_pixel = x + sign(hspd)
				if next_pixel != goalX {
					x += sign(hspd)	
				} else { 
					#region	Arrived at goal
						debug_log("I have arrived at my goal")
						hspd = 0
						
						//	What object was our goal?
						switch(goal.object_index)
						{
							#region Elevator
								case elevator:
								case elevator_child:
								case elevator_2floors_starts1:
									//	Check if elevators here, if so get on it
									debug_log("Checking for elevator")
									if (goal.y-sprite_height == y) {
										var where_im_standing = irandom_range(goal.x-(sprite_width/2)+32,goal.x+(sprite_width/2)-32)
										var _goalpost = instance_create_layer(where_im_standing,y,"Instances_controller",goalpost)
										_goalpost.goal_type = goal_type.elevator_board
										_goalpost.elevator = goal
										
										ds_list_add(goal.passenger_list,id)
										
										ds_stack_pop(goal_queue)
										
										ds_stack_push(goal_queue,_goalpost)
										goal = ds_stack_top(goal_queue)
										goalX = goal.x
										
										debug_log("My new goal is "+string(object_get_name(ds_stack_top(goal_queue).object_index)))
										
										debug_log("I am boarding an elevator")
									} else {
										debug_log("ERROR No elevator! ERROR")	
									}
								
								
								break;
							#endregion
							
							#region Goalpost
								case goalpost:
									//	What kind of goalpost
									switch(goal.goal_type)
									{
										//	I just boarded an elevator
										case goal_type.elevator_board:
										
											debug_log("I just boarded an elevator")
											
											states = states.elevator
											
											instance_destroy(goal)
											ds_stack_pop(goal_queue)
											goal = ds_stack_top(goal_queue)
											goalX = goal.x
											Direction = sign(goalX - x)
											
											show_debug_message("["+string(time.stream)+"] I have " +string(ds_stack_size(goal_queue)) + " goal to do!")
											debug_log("My new goal is "+string(object_get_name(ds_stack_top(goal_queue).object_index)))
											
										break;
									}
									
									
								break
							#endregion
							
							#region Door
								case door:
									states = states.idle
								
									var old_door_GID = DoorGID
								
									DoorGID = goal								
									DoorID = goal.ID
									
									ds_list_add(guestController.vacancy_list,old_door_GID)
									ds_list_add(guestController.vacancy_list,DoorGID)
									
									ds_stack_pop(goal_queue)
									
									instance_destroy()												
								
								break;
							#endregion
						}
					
					#endregion
				}	
			}
	
	
		break
	#endregion
	
	#region Elevator
		case states.elevator:
	
			//	If I have arrived
			if Floor == goal.Floor {
				debug_log("I have arrived at the floor of my goal: "+string(object_get_name(ds_stack_top(goal_queue).object_index)))
				
				states = states.walk
			}
	
	
		break;
	#endregion
}
