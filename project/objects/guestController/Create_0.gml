room_list = ds_list_create()
guest_list = ds_list_create()

//	How many guests we got
for(var i=0;i<ds_list_size(room_list);i++) {
	guest_list[| i] = room_list
}