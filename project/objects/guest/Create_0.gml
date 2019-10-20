image_blend = c_aqua

Floor = 0
DoorID = 0
DoorGID = 0

Direction = 0
hspd = 0

movespeed = 3

idle_time = 0

goalX = 0
goal = 0
goal_queue = ds_stack_create()

states = states.idle

ds_list_add(guestController.guest_list,id)
ds_list_add(guestController.guest_active_list,id)