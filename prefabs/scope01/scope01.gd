extends Node3D
# https://stackoverflow.com/questions/75770515/how-to-create-a-subviewport-viewporttexture-programmatically-in-godot
@export_flags_3d_render var render_layer: int

@onready var sub_viewport = $SubViewport
@onready var sprite_3d = $Sprite3D
@onready var camera_3d = $SubViewport/Camera3D

func _ready():
	#var rect = get_viewport().size
	#sub_viewport.get_viewport().size = rect
	#set_child_visual_layer_recursive(self)
	sprite_3d.texture = sub_viewport.get_texture() # Just get the texture directly.
	pass

func _process(_delta):
	#var rect = get_viewport().size
	#print(rect)
	#sub_viewport.get_viewport().size = rect
	#sub_viewport.set_size(rect)
	
	#texture = $SubViewport.get_texture()
	camera_3d.transform = transform
	pass


func set_child_visual_layer_recursive(node: Node):
	var children = node.get_children(true)
	for c in children:
		if c.get_child_count(true) > 0:
			set_child_visual_layer_recursive(c)
		if c is VisualInstance3D:
			c.layers = render_layer
