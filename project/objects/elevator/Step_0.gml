switch(states) 
{
	#region Idle
	case states.idle:
	
	break
	#endregion
	#region Elevator
	case states.elevator:
	
		// If we're not at the next floor yet
		var destination = floors_y[current_floor-floor_direction]	
		if y != destination {	
			
			vspd += floor_direction
			
			vspd = clamp(vspd,-movespeed,movespeed)
			
			//	Move elevator and player in elevators direction
			repeat(abs(vspd)) {
				var new_y
				new_y = y + sign(vspd)
				if y != new_y {
					y += sign(vspd)
					for(var i=0;i<ds_list_size(passenger_list);i++) {
						passenger_list[| i].y += sign(vspd)
					}					
				} else {
					vspd = 0	
				}
			}
			
		} else {
			
			//	Ding ding, we've arrived!
			states = states.idle
			player.states = states.idle
			Floor = Floor - floor_direction
			
			var new_passenger_list = ds_list_create()
			ds_list_copy(new_passenger_list,passenger_list)
			
			for(var i=0;i<ds_list_size(passenger_list);i++) {
				var _passenger = passenger_list[| i]
				_passenger.Floor = Floor	
							
				if (_passenger.object_index == guest) {
					
					//	Is this your floor?
					if _passenger.Floor == _passenger.goal.Floor {
						ds_list_delete(new_passenger_list,ds_list_find_index(new_passenger_list,_passenger.id))
					} else {
						
					}
					
				} else {
					//	Passenger is the player
					ds_list_delete(new_passenger_list,ds_list_find_index(new_passenger_list,_passenger.id))
				}						
				
			}
			
			ds_list_clear(passenger_list)
			ds_list_copy(passenger_list,new_passenger_list)
			
			//	Calc arrow colors 
			up_arrow_color = 0 
			down_arrow_color = 0
			if ds_list_size(new_passenger_list) > 0 {
				for(var i=0;i<ds_list_size(new_passenger_list);i++) {
					var _passenger = new_passenger_list[| i]
					if _passenger.object_index == guest {
						with _passenger {
							if vDirection > 0 other.down_arrow_color = 1
							if vDirection < 0 other.up_arrow_color = 1
						}
					}
						
				}
			}

			current_floor = current_floor - floor_direction
			floor_direction = 0
			
			//	Calculate arrows
			if current_floor == 0 {
				//	No more floors under me				
				down_arrow = 0	
			} else {
				down_arrow = 1	
			}
			var _floor = current_floor + 1
			if _floor < floors {
				up_arrow = 1	
			} else {
				up_arrow = 0	
			}
			
		}
	break
	#endregion
}
