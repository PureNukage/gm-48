switch(states) 
{
	#region Idle
	case states.idle:
	
	break
	#endregion
	#region Elevator
	case states.elevator:
	
		// If we're not at the next floor yet
		if y != floors_y[current_floor-floor_direction] {
			
			//	Move elevator and player in elevators direction
			y += floor_direction
			for(var i=0;i<ds_list_size(passenger_list);i++) {
				passenger_list[| i].y += floor_direction	
			}
			
		} else {
			
			//	Ding ding, we've arrived!
			states = states.idle
			player.states = states.idle
			Floor = Floor - floor_direction
			for(var i=0;i<ds_list_size(passenger_list);i++) {
				passenger_list[| i].Floor = Floor	
			}
			ds_list_clear(passenger_list)
			current_floor = current_floor - floor_direction
			floor_direction = 0
			
		}
	break
	#endregion
}