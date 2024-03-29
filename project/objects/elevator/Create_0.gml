image_blend = c_green
depth = -1;
states = states.idle

Floor = 0

shaft = []
shaft[0] = x-(sprite_width/2)
shaft[1] = x+(sprite_width/2)

vspd = 0
movespeed = 3

up_arrow = 0
up_arrow_color = 0
up_arrow_color_value = c_red
down_arrow = 0
down_arrow_color = 0
down_arrow_color_value = c_red

passenger_list = ds_list_create()

//	Loop for filling in array y-positions of my floors
for(var i=0;i<floors;i++) {		
	if i == current_floor {
		floors_y[i] = y
	} else {
		floors_y[i] = y+(floor_gap*(current_floor-i))
	}
	show_debug_message("floor: "+string(i)+" at y: "+string(floors_y[i]))
}

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

//	Add ourselves into the elevator list
ds_list_add(guestController.elevator_list,id)

/*	Everything under this are the values you can change as a child

floors = 2						//	The number of floors this elevator has
current_floor = 0				//	The floor this elevator is starting at (WIP)
floor_direction = 0				//	Which direction the floor is moving in currently
floors_y = []					//	An array containing all of my floors Y-positions 

floor_gap = 288				//	The distance in between floors (needs to be the same for all floors)