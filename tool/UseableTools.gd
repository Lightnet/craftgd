extends Node3D

var current_tool_index = 0

func _ready():
	update_tools()
	pass

func _process(_delta):
	
	if Input.is_action_just_pressed("switch_tool"):
		current_tool_index += 1
		update_tools()
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
