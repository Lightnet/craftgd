extends Sprite3D

func _ready():
	texture = $SubViewport.get_texture()
	pass 

func update_health(_value, max_value):
	#print("HEALTH3D: ", _value,"/", max_value)
	$SubViewport/Control/HealthBar2D.update_health(_value, max_value)
