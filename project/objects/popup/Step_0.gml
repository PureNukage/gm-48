if time.seconds == death {
	ds_list_delete(popupController.popup_list,ds_list_find_index(popupController.popup_list,id))
	instance_destroy()
}

//	Move horizontally with camera
x = camera_get_view_x(camera.cam) + camera_get_view_width(camera.cam)/2
y = height