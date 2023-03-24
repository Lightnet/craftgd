@tool
extends Sprite3D

@onready var label = $SubViewport/Label
@onready var sub_viewport = $SubViewport

@export var text:String = "Test!" : 
	set(value):
		text = value
		updateText(value)
		
@export var width = 128:
	set(value):
		width = value
		#print("sub_viewport ", sub_viewport)
		#print("sub_viewport.size(): ", sub_viewport.size)
		#sub_viewport.size().get_size().x
		sub_viewport.set_size(Vector2(width, height))
		#label.set_custom_minimum_size(Vector2(width, height))

@export var height = 128:
	set(value):
		height = value
		#sub_viewport.size().get_size().x
		sub_viewport.set_size(Vector2(width, height))
		#label.set_custom_minimum_size(Vector2(width, height))

func _ready():
	texture = $SubViewport.get_texture()
	#updateText(text)
	pass
	
#func _process(delta):
	#pass

func updateText(_text:String):
	if _text and label:
		label.text = _text
