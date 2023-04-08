extends Control

@onready var l_name = $CenterContainer/VBoxContainer/LName
@onready var l_level = $CenterContainer/VBoxContainer/LLevel
@onready var l_damage = $CenterContainer/VBoxContainer/LDamage

var damage = 0
var level = 0

func update_name(_name):
	l_name.text = _name
	
func update_data(_level,_damage):
	l_level.text = "Level:" + str(_level)
	l_damage.text = "Level:" + str(_damage)
	pass
