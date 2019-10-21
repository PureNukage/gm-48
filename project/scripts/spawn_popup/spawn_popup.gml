/// @function spawn_popup(string,color)
/// @description 
/// @param {string} string 
/// @param {color} color 
/// @param {color} time 

var _message = argument[0]
var _color = argument[1]
var _time = argument[2]

var _spacer = 64
var _y = 128
_y = _y + (_spacer*instance_number(popup))

var _screen_y = player.y
_screen_y = _screen_y - display_get_gui_height()/2
_screen_y += _y

var screen_x = surface_get_width(application_surface)/2

var _popup = instance_create_layer(screen_x,_screen_y,"Instances_controller",popup)

var real_time = time.seconds

real_time += _time

_popup.message = _message
_popup.color = _color
_popup.death = real_time