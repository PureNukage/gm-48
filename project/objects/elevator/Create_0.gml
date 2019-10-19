image_blend = c_green
depth = -1;
states = states.idle

floors = 2						//	The number of floors this elevator has
current_floor = 0				//	The floor this elevator is starting at (WIP)
floor_direction = 0				//	Which direction the floor is moving in currently
floors_y = []					//	An array containing all of my floors Y-positions 

var floor_gap = 288				//	The distance in between floors (needs to be the same for all floors)


//	Loop for filling in array y-positions of my floors
for(var i=0;i<floors;i++) {		
	if i == current_floor {
		floors_y[i] = y
	} else {
		floors_y[i] = y+(floor_gap*(current_floor-i))
	}
	show_debug_message("floor: "+string(i)+" at y: "+string(floors_y[i]))
}