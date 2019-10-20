switch(states)
{
	#region Idle 
	case states.idle:
	
		//	Horizontal movement
		hspd += playerInput.key_right - playerInput.key_left

		//	Stop moving when not inputting
		if !playerInput.key_right and !playerInput.key_left hspd = lerp(hspd,0,fric)

		//	Clamp for max movespeed
		hspd = clamp(hspd,-movespeed,movespeed)

		//	Apply horizontal thrust while collision checking each pixel movement
		repeat(abs(hspd)) {
			if !place_meeting(x+sign(hspd),y+sign(vspd),block) {
				x += sign(hspd)	
			} else { 
				hspd = 0
			}	
		}
		
		#region	Use Elevator
		
		if (playerInput.key_up_pressed or playerInput.key_down_pressed) and place_meeting(x,y+1,elevator) {
			var _elevator = instance_place(x,y+1,elevator)
			
			// We wanting to go up or down
			var _direction = playerInput.key_down_pressed - playerInput.key_up_pressed
			var hypothetical_nextfloor = _elevator.current_floor - _direction
			
			debug_log("hypothetical nextfloor: "+string(hypothetical_nextfloor))
			
			//	If the floor we wish to go to exists
			if (hypothetical_nextfloor != _elevator.floors and hypothetical_nextfloor != -1) {
				states = states.elevator
				_elevator.states = states.elevator
				_elevator.floor_direction = playerInput.key_down_pressed - playerInput.key_up_pressed
				ds_list_add(_elevator.passenger_list,id)
			}
		}	
		#endregion
		
	break
	#endregion
	#region Elevator
	case states.elevator:
		
		
	
	break;
	#endregion
}
