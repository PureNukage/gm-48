draw_self()

//	Draw Comic Bubble
if wait_time > time.seconds {
	draw_sprite_ext(s_bubble,0,x,y-96,2,2,0,c_white,1)	
	draw_set_halign(fa_center)
	draw_set_color(c_black)
	draw_text(x,y-128,string(wait_time-time.seconds))
	draw_set_halign(fa_left)
}