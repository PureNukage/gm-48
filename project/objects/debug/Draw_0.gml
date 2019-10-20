switch(mode)
{
	case 0:
	
	break
	case 1:
		draw_set_color(c_black)

		with player {
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
			draw_text(x-64,y-80,"floor: "+string(Floor))
			draw_text(x-64,y-95,"door: "+string(DoorID))
			draw_text(x-64,y-110,"goalX: "+string(goalX))
			draw_text(x-64,y-125,"x: "+string(x))
			draw_text(x-64,y-140,"GID: "+string(id))
		}	
	break
	case 2:
	
	break
	
}