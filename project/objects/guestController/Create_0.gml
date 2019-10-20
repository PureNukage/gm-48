door_list = ds_list_create()
vacancy_list = ds_list_create()
guest_list = ds_list_create()
guest_active_list = ds_list_create()
guest_indoors_list = ds_list_create()
elevator_list = ds_list_create()

guests_starting = 2		//	Starting number of guests in the level (probably shouldn't exceed #doors in level)

guests_active_clamp = 4		//	Maximum number of guests out of their doors at once (larger == harder, presumably)