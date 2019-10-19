switch(states)
{
	case states.idle:
	
	//	I got something to do!
	if goal != 0 {
		
		// Is my goal above me, under me or on the same floor?
		var vDirection = sign(Floor - goal.Floor)
		
		switch(vDirection)
		{
			case -1:	//	My goal is above me
			case 1:		//	My goal is under me
			
				#region	Lets check if any elevators are on this floor
					for(var elev=0;elev<ds_list_size(guestController.elevator_list);elev++) {
						var _elevator = guestController.elevator_list[| elev]
						var elevators_on_this_floor = ds_list_create()
						
						//	This elevators on the same floor as us!
						if _elevator.Floor == Floor {	
							ds_list_add(elevators_on_this_floor,id)
						}
					}
				#endregion
				
				#region	We have an elevator on our floor			
					if ds_list_size(elevators_on_this_floor) > 0 {
						var how_many = ds_list_size(elevators_on_this_floor)
						#region	Sort elevators into closest -> furthest
							var distance_list = ds_list_create()						
							for(var elv=0;elv<how_many;elv++) {
							
								//	Distance between guest and elevator
								var distance = abs(elevators_on_this_floor[| elv].x - x)
								ds_list_add(distance_list,distance)
							}
							
							//	Copy this list and then sort it
							var distance_list_sorted = ds_list_create()
							ds_list_copy(distance_list_sorted,distance_list)
							ds_list_sort(distance_list_sorted,true)
							
							//	Make this elevator our goal 
						
						#endregion
						
					
					} 
				
				#endregion		
				#region No elevators on this floor
					else {

					}
				#endregion
				
			break;
			case 0:		//	My goal is on the same floor as me
			
			break;
		}
			
	}
	
	break
	case states.walk:
	
		
	
	
	break
}