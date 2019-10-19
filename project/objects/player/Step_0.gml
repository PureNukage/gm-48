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
		
		//	Use Elevator
		if playerInput.key_up {
			
		}	
		
	break
	#endregion
	#region Elevator
	case states.elevator:
		
		
	
	break;
	#endregion
}
