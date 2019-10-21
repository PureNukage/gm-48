draw_self()

//	Draw Comic Bubble
if wait_time > time.seconds {
	
	var _x = x
	var _y = y-96
	
	//	If on screen 
	if x > camera_get_view_x(camera.cam) and x < camera_get_view_x(camera.cam)+camera_get_view_border_x(camera.cam) and 
	y > camera_get_view_y(camera.cam) and y < camera_get_view_y(camera.cam)+camera_get_view_border_y(camera.cam) {		
		
		_x = x
		_y = y-96
		
	} else {
		
		_x = clamp(_x,camera_get_view_x(camera.cam)+32,camera_get_view_x(camera.cam)+camera_get_view_border_x(camera.cam)-32 )
		_y = clamp(_y,camera_get_view_y(camera.cam)+32,camera_get_view_y(camera.cam)+camera_get_view_border_y(camera.cam)-32 )		
		
	}	
	
	draw_sprite_ext(s_bubble,0,_x,_y,2,2,0,c_white,1)	
	draw_set_halign(fa_center)
	draw_set_color(c_black)
	draw_text(_x,_y-34,string(wait_time-time.seconds))
	draw_set_halign(fa_left)
}