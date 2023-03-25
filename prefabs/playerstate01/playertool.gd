extends Node

@onready var right_hand = $"../Camera3D/RightHand"
#for place tool on this hand
@onready var remote_handle = $"../Camera3D/RightHand/RemoteHandle"
@onready var ray_aim = $"../Camera3D/RayAim"

var isRayAim:bool = true # deal with animation 

var current_tool_index = 0

func _ready():
	update_tools()
	pass

func _process(_delta):
	
	if Input.is_action_just_pressed("switch_tool"):
		current_tool_index += 1
		update_tools()
	pass
	
func _physics_process(_delta):
	
	#hand look at ray cast or mark 3D
	if isRayAim:
		right_hand.look_at(ray_aim.hitpoint)#global
	pass
	
func update_tools():
	#for child in get_children():
	if current_tool_index >= get_child_count():
		current_tool_index = 0
	print(get_child_count())
	for child in get_child_count():
		get_child(child).hide()
		get_child(child).set_process(false)
	get_child(current_tool_index).show()
	get_child(current_tool_index).set_process(true)
	var item = get_child(current_tool_index)
	print(item)
	if item:
		#get remote transform and get current item node path
		remote_handle.set_remote_node(item.get_path())
		#remote_handle.remote_path = item.tran
