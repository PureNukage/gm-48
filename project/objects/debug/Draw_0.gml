switch(mode)
{
	case 0:
	
	break
	case 1:
		draw_set_color(c_black)

		with player {
			draw_text(x-64,y-155,"speed: "+string(hspd))
			draw_text(x-64,y-135,"hp :"+string(hp))
			draw_text(x-64,y-120,"y: "+string(y))
			draw_text(x-64,y-105,"Floor: "+string(Floor))	
		}

		with elevator {
			draw_text(x-64,y-140,"GID: "+string(id))
			draw_text(x-64,y-125,"Floor: "+string(Floor))
			draw_text(x-64,y-110,"relative floor: "+string(current_floor)+"/"+string(floors-1))
			draw_text(x-64,y-95,"shaft 0: "+string(shaft[0]))
			draw_text(x-64,y-80,"shaft 1:" +string(shaft[1]))	
		}

		with door {
			draw_text(x-64,y-120,"floor: "+string(Floor))
			draw_text(x-64,y-135,"ID: "+string(ID))	
			draw_text(x-64,y-150,"GID: "+string(id))
		}

		with guest {
			var _y = 80
			draw_text(x-64,y-_y,"floor: "+string(Floor))				_y += 15
			draw_text(x-64,y-_y,"door: "+string(DoorID))				_y += 15
			draw_text(x-64,y-_y,"goalX: "+string(goalX))				_y += 15
			draw_text(x-64,y-_y,"x: "+string(x))						_y += 15
			draw_text(x-64,y-_y,"GID: "+string(id))						_y += 15
			draw_text(x-64,y-_y,"speed: "+string(hspd))					_y += 15
			draw_text(x-64,y-_y,"wait time: "+string(wait_time))		_y += 15
			draw_text(x-64,y-_y,"Elevator: "+string(Elevator))			_y += 15
			
		}	
	break
	case 2:
	
	break
	
}