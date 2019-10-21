switch(states)
{
	#region Idle
		case states.idle:
	
		#region	I got something to do!	
			if ds_stack_size(goal_queue) > 0 {
		
				debug_log("I have " +string(ds_stack_size(goal_queue)) + " goal(s) to do!")
				debug_log("My goal is "+string(object_get_name(ds_stack_top(goal_queue).object_index)))
				debug_log("I am on floor "+string(Floor))
		
				goal = ds_stack_top(goal_queue)
		
				// Is my goal above me, under me or on the same floor?
				vDirection = sign(Floor - goal.Floor)
		
				switch(vDirection)
				{
					case -1:	//	My goal is above me
					case 1:		//	My goal is under me
				
					if vDirection == -1 var _direction = "above"
					if vDirection == 1 var _direction = "under"
					debug_log("My goal is "+string(_direction)+" me!")
					#region Elevator check
				
						#region	Lets check if any elevators are on this floor
							var elevators_on_this_floor = ds_list_create()						
							for(var elev=0;elev<ds_list_size(guestController.elevator_list);elev++) {
								var _elevator = guestController.elevator_list[| elev]
						
								//	This elevators on the same floor as us!
								if _elevator.Floor == Floor {	
									debug_log("Elevator "+string(_elevator)+" is on the same floor as me")
									
									//	Make sure this elevator goes to our desired floor							
									var _desired_floor = Floor
									var desired_floor = _desired_floor - vDirection
									debug_log("My desired floor is "+string(desired_floor))
									
									var desired_floor_y = guestController.floors_list[| goal.Floor]
									
									for(var des=0;des<_elevator.floors;des++) {
										if _elevator.floors_y[des]-64 == desired_floor_y {							
											ds_list_add(elevators_on_this_floor,_elevator)
											debug_log("Elevator "+string(_elevator)+" goes to my desired floor")
										}
									}
								}
							}
							
							var debug_elevators_on_this_floor_size = ds_list_size(elevators_on_this_floor)
							debug_log("There are "+string(debug_elevators_on_this_floor_size)+" elevators on my floor")
							
						#endregion				
					
							if ds_list_size(elevators_on_this_floor) > 0 {
								#region We have an elevator on this floor 
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
										debug_log("my x: " +string(x))
										debug_log("goalX "+string(goalX))									
										debug_log("direction: "+string(Direction))
						
										states = states.walk
						
									#endregion				
								#endregion
					
							} else {
								#region	No elevators on this floor
								
									#region	Guest waits at elevator shaft
										var all_elevators_distance = ds_list_create()
									
										//	Find nearest elevator shaft 
										for(var elev=0;elev<ds_list_size(guestController.elevator_list);elev++) {
											//	Does this elevator come to my floor and go to the floor I want?
											var comes_to_my_floor = 0
											var goes_to_desired_floor = 0
											for(var elv=0;elv<guestController.elevator_list[| elev].floors;elv++) {
												if guestController.elevator_list[| elev].floors_y[elv]-64 == y {
													comes_to_my_floor++
													//	Does it also go to the floor I want?
													var _elevator_ = guestController.elevator_list[| elev]
													var _desired_elevator_y = guestController.elevator_list[| goal.Floor]
													for(var des=0;des<_elevator_.floors;des++) {
														if _elevator_.floors_y[des]-64 == _desired_elevator_y {
															goes_to_desired_floor++	
														}
													}
													
												}
											}
											if comes_to_my_floor > 0 and goes_to_desired_floor > 0 {
												var distance = abs(guestController.elevator_list[| elev].x - x)
												ds_list_add(all_elevators_distance,distance)
											}
										}
									
										var elev_id = 0
										ds_list_sort(all_elevators_distance,true)
										for(var i=0;i<ds_list_size(guestController.elevator_list);i++) {
											with guestController.elevator_list[| i] {
												var _distance = abs(x - other.x)
												if _distance == all_elevators_distance[| 0] {
													elev_id = id	
												}
											}
										}
									
										if elev_id != 0 {
											
											ds_stack_push(goal_queue,elev_id)
											goal = elev_id
						
											var which_side_of_elevator = 0
											var which_side_of_elevator_raw = sign(elev_id.x - x)
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
										} else {
											debug_log("No elevator shafts on this floor! That... doesn't make any sense")	
										}
								
								
									#endregion	
									
								#endregion
							}	
						
				
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
					if ds_list_find_index(goal.Elevator.passenger_list,id) == -1 {
						ds_list_add(goal.Elevator.passenger_list,id)
					}
				}
				
			#endregion
			
			hspd += Direction*movespeed
			
			hspd = clamp(hspd,-movespeed,movespeed)
			
			//	Double check direction
			Direction = sign(goalX - x)		
			
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
									#region	Check if elevators here
									debug_log("Checking for elevator")
									
										#region Elevators here, all aboard
											if (goal.y-sprite_height == y) {
												var where_im_standing = irandom_range(goal.x-(sprite_width/2)+32,goal.x+(sprite_width/2)-32)
												var _goalpost = instance_create_layer(where_im_standing,y,"Instances_controller",goalpost)
												_goalpost.goal_type = goal_type.elevator_board
												_goalpost.Elevator = goal
												_goalpost.Floor = goal.Floor
										
												ds_list_add(goal.passenger_list,id)											
										
												ds_stack_pop(goal_queue)
										
												ds_stack_push(goal_queue,_goalpost)
												goal = ds_stack_top(goal_queue)
												goalX = goal.x
											
												Direction = sign(goalX - x)
												
												guest_wait()
										
												debug_log("My new goal is "+string(object_get_name(ds_stack_top(goal_queue).object_index)))
										
												debug_log("I am boarding an elevator")
											} 
										#endregion
									
										#region	Elevators not here yet 
											else {
										
												//	Are there any other elevators on this floor?
												var other_elevator = 0
												with elevator {
													if other.y == y-64 {
														other_elevator = id	
													}
												}
												if other_elevator != 0 {
													debug_log("Going to a different elevator on this floor")
												
													//	Remove ourselves from current elevator passenger_list
													ds_list_delete(goal.passenger_list,ds_list_find_index(goal.passenger_list,id))	
												
													debug_log("Deleting "+string(ds_stack_top(goal_queue))+" from the goal queue")
													ds_stack_pop(goal_queue)
												
													ds_stack_push(goal_queue,other_elevator)
													goal = other_elevator
						
													var which_side_of_elevator = 0
													var which_side_of_elevator_raw = sign(other_elevator.x - x)
													if which_side_of_elevator_raw == -1 which_side_of_elevator = 1
													else which_side_of_elevator = 0
									
													debug_log("moving towards goal! name: "+string(object_get_name(goal.object_index))+" , GID: "+string(goal))
													debug_log("taking the "+string(which_side_of_elevator)+" elevator shaft")
									
													goalX = goal.shaft[which_side_of_elevator]
													Direction = sign(goalX - x)
													goalX += sign(Direction)*-31
													debug_log("my x: "+string(x))
													debug_log("goalX "+string(goalX))									
													debug_log("direction: "+string(Direction))
						
													states = states.walk
												} else {
													//debug_log("I should be going to a shaft!")
													debug_log("ERROR No elevator! ERROR")	
													
													//	I should be waiting if I'm not already
													if wait_time <= time.seconds and wait_time == 0 {
														guest_wait()	
													} 
													
												}
										
											}
										#endregion
										
									#endregion
								
								break;
							#endregion
							
							#region Goalpost
								case goalpost:
									//	What kind of goalpost
									switch(goal.goal_type)
									{
										#region	I just boarded an elevator
											case goal_type.elevator_board:
										
												debug_log("I just boarded an elevator")
											
												states = states.elevator
												
												Elevator = goal.Elevator
												
												debug_log("vDirection: "+string(vDirection))
												if vDirection > 0 goal.Elevator.down_arrow_color = 1
												if vDirection < 0 goal.Elevator.up_arrow_color = 1
											
												instance_destroy(goal)
												ds_stack_pop(goal_queue)
												goal = ds_stack_top(goal_queue)
												goalX = goal.x
												Direction = sign(goalX - x)
											
												debug_log("I have " +string(ds_stack_size(goal_queue)) + " goal to do!")
												debug_log("My new goal is "+string(object_get_name(ds_stack_top(goal_queue).object_index)))
											
											break;
										#endregion
										
										#region	I am doing something
											case goal_type.do_something:
												
												states = states.idle_activity
												
												idle_time = irandom_range(60,140)
												
												instance_destroy(goal)
												ds_stack_pop(goal_queue)																		
												
												Direction = 0
												
												
											break
										#endregion
									}
									
									
								break
							#endregion
							
							#region Door
								case door:
								
									states = states.indoors
									
									ds_list_delete(guestController.guest_active_list,ds_list_find_index(guestController.guest_active_list,id))
									ds_list_add(guestController.guest_indoors_list,id)
									
									image_alpha = 0								
								
									DoorGID = goal								
									DoorID = goal.ID								
									
									ds_stack_clear(goal_queue)
																					
								
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
		
			//	If my elevator is moving
			if abs(Elevator.vspd) > 0.2 {
				
				//	If I'm waiting, pause my wait_time
				if wait_time > 0 and time.seconds_switch wait_time++	

					
			} 
			
			//	If my elevator is not moving 
			else {
				
				//	Should I be pissed? (LAZY FIX)
				if time.seconds != 0 and time.seconds >= wait_time and wait_time != 0 {
					//Elevator = 0
					states = states.walk
				}
			}
		
	
			//	If I have arrived
			if Floor == goal.Floor {
				debug_log("I have arrived at the floor of my goal: "+string(object_get_name(ds_stack_top(goal_queue).object_index)))
				
				wait_time = 0
				
				Elevator = 0
				
				vDirection = 0
				states = states.walk
			}
	
	
		break;
	#endregion
	
	#region	Indoors
		case states.indoors:
			
			x = DoorGID.x
			
			if ds_list_find_index(guestController.guest_active_list,id) != -1 {
				ds_list_delete(guestController.guest_active_list,ds_list_find_index(guestController.guest_active_list,id))	
			}
			
		
		break;
	#endregion
	
	#region Idle Activity
		case states.idle_activity:
			
			if idle_time > 0 idle_time--
			else {
				
				//	Idling is over! Heading back to my room
				debug_log("Idle is over. Heading back to my door")
				
				ds_stack_push(goal_queue,DoorGID)
				
				states = states.idle
				
			}
			
			
			
			
		break
	#endregion
	
	#region Pissed
		case states.pissed:
		
			//	I'm outta here
			hspd += Direction*movespeed
			
			hspd = clamp(hspd,-movespeed,movespeed)
		
			x += hspd
		break
	#endregion
}

#region Get Pissed Off 
	if states != states.pissed {
		//	I waited too long and am now pissed off!
		if time.seconds != 0 and time.seconds >= wait_time and wait_time != 0 {	

			debug_log("I am pissed off and outta here")
			
			spawn_popup("A guest has left the hotel!",c_red,3)
			
			//	Was I in an elevator? If so remove myself and recalc elevators light switches
			if Elevator != 0 {
				debug_log("I was in an elevator!")
				ds_list_delete(Elevator.passenger_list,ds_list_find_index(Elevator.passenger_list,id))
				//	Calc arrow colors 
				var _up_arrow_color = 0 
				var _down_arrow_color = 0
				if ds_list_size(Elevator.passenger_list) > 0 {
					for(var i=0;i<ds_list_size(Elevator.passenger_list);i++) {
						var _passenger = Elevator.passenger_list[| i]
						if _passenger.object_index == guest {
							with _passenger {
								if vDirection > 0 _up_arrow_color = 1
								if vDirection < 0 _down_arrow_color = 1
							}
						}						
					} 
					Elevator.up_arrow_color = _up_arrow_color
					Elevator.down_arrow_color = _down_arrow_color					
				} else {
					Elevator.up_arrow_color = 0
					Elevator.down_arrow_color = 0
				}
				
				Elevator = 0
				
			}
			
		
			states = states.pissed
		
			var random_direction = choose(-1,1)
		
			Direction = random_direction	
			
			//	Delete ourselves data wise
			ds_list_delete(guestController.guest_list,ds_list_find_index(guestController.guest_list,id))
	
			//	Free up our door
			ds_list_add(guestController.vacancy_list,DoorGID)
			DoorGID.vacant = true
			
			guestController.guest_time_last_one_left = time.seconds
			
			//	Destroy all goalposts in goal stack
			var goal_list = ds_list_create()
			var stack_size = ds_stack_size(goal_queue)
			debug_log("Destroying "+string(stack_size)+" goals")
			while ds_stack_size(goal_queue) > 0 {
				ds_list_add(goal_list,ds_stack_pop(goal_queue))
			}
			for(var i=0;i<ds_list_size(goal_list);i++) {
				var _goal = goal_list[| i]
				if _goal.object_index == goalpost {
					debug_log("Destroying my goal of: "+string(object_get_name(_goal.object_index)))
					instance_destroy(_goal)	
				}	

			
		
			}
	
		}
	}
#endregion	