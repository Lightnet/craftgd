extends TextureProgressBar

var bar_red = preload("res://prefabs/healthbar3d/barHorizontal_red_mid_200.png")
var bar_green = preload("res://prefabs/healthbar3d/barHorizontal_green_mid_200.png")
var bar_yellow = preload("res://prefabs/healthbar3d/barHorizontal_yellow_mid_200.png")

func _ready():
	#hide()
	texture_progress = bar_green
	pass

func update_health(_value, _max_value):
	#print("HEALTH: ",_value ,"/",_max_value)
	value = _value
	max_value = _max_value
	if value < _max_value:
		show()
		pass
	texture_progress = bar_green
	if value < 0.75 * _max_value:
		texture_progress = bar_yellow
	if value < 0.45 * _max_value:
		texture_progress = bar_red
		
	
