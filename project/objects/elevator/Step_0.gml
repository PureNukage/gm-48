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
			player.y += floor_direction
			
		} else {
			
			//	Ding ding, we've arrived!
			states = states.idle
			player.states = states.idle
			current_floor = current_floor - floor_direction
			floor_direction = 0
			
		}
	break
	#endregion
}