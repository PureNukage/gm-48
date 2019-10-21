//	A popup expired! Time to recalc their heights
if popup_size != ds_list_size(popup_list) {
	popup_size = ds_list_size(popup_list)
	var _y = 128
	//camera_get_view_x(camera.cam) + camera_get_view_width(camera.cam)/2
	var top = camera_get_view_y(camera.cam)
	for(var i=0;i<ds_list_size(popup_list);i++) {
		popup_list[| i].height = top + _y
		_y += 128
	}
}
