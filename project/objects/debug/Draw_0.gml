if mode == true {

	draw_set_color(c_black)

	with player {
		draw_text(x-64,y-120,"y: "+string(y))
		draw_text(x-64,y-105,"Floor: "+string(Floor))	
	}

	with elevator {
		draw_text(x-64,y-110,"Floor: "+string(Floor))
		draw_text(x-64,y-95,"shaft 0: "+string(shaft[0]))
		draw_text(x-64,y-80,"shaft 1:" +string(shaft[1]))	
	}

	with door {
		draw_text(x-64,y-120,"floor: "+string(Floor))
		draw_text(x-64,y-135,"ID: "+string(ID))	
	}

	with guest {
		draw_text(x-64,y-80,"floor: "+string(Floor))
		draw_text(x-64,y-95,"door: "+string(DoorID))
	}	
	
}