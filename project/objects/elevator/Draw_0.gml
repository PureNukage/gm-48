draw_self()

//	Draw arrows
if up_arrow == 1 {
	if up_arrow_color == 1 {
		up_arrow_color_value = c_yellow	
	} else {
		up_arrow_color_value = c_red
	}
} else {
	up_arrow_color_value = c_gray
}
draw_sprite_ext(s_arrow,0,x-32,y-96,1,1,0,up_arrow_color_value,1)	

if down_arrow == 1 {
	if down_arrow_color == 1 {
		down_arrow_color_value = c_yellow
	} else {
		down_arrow_color_value = c_red
	}
} else {
	down_arrow_color_value = c_gray	
}
draw_sprite_ext(s_arrow,0,x+32,y-160,1,-1,0,down_arrow_color_value,1)