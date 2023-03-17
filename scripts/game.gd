extends Node

# towerdefense
# survival
# deathmatch
# teamdeathmatch
# skyblock
# extract
# intel

#var mode = "none"

signal mode(_name)
var current_mode:String = "none"

func set_mode(_name):
	print("MODE: ",_name)
	current_mode = _name
	pass

func get_mode():
	return current_mode



# menu for input dis/enable
# chat box
# player controller
# vehicle
# inventory
# build

var menu = "none"

var inventory = []

func _ready():
	mode.connect(set_mode)
	
	pass 

#func _process(delta):
	#pass


