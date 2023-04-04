extends Node3D
# https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-is-processing
@onready var ray_cast_3d = $RayCast3D

@export var ph = preload("res://prefabs/prototyping/placeholders/ph_light_cube.tscn")
@export var placeitem = preload("res://prefabs/prototype/turret01/turret_01.tscn")
var tmp_ph

@export var ph_wall = preload("res://prefabs/prototyping/placeholders/ph_light_cube.tscn")
@export var wall = preload("res://prefabs/prototyping/light_grid_cube.tscn")

@export var ph_gate = preload("res://prefabs/prototyping/placeholders/ph_light_cube.tscn")
@export var gate = preload("res://prefabs/prototype/turret01/turret_01.tscn")

@export var ph_turret = preload("res://prefabs/prototype/turret01/ph_turret_01.tscn")
@export var turret = preload("res://prefabs/prototype/turret01/turret_01.tscn")


@onready var create_timer = $CreateTimer
@onready var construct_menu = $CanvasLayer/construct_menu

var isPlace:bool = true

func _ready():
	tmp_ph = ph.instantiate()
	get_node("/root/main").add_child.call_deferred(tmp_ph)
	pass

func _exit_tree():
	if tmp_ph:
		tmp_ph.queue_free()
	pass

#func _unhandled_input(_event):
	#print("get_process_mode: ", self.get_process_mode())
	#print("is_processing: ", is_processing())
	#print("can_process : ", self.can_process ())
	#pass
	
func _input(event):
	#print("process_mode: ",process_mode)
	#print("get_process_mode: ",get_process_mode())
	if not is_processing():#if component not enable return to prevent event input
		return
	if event.is_action_released("build_menu"):
		construct_menu.visible = !construct_menu.visible
		print("construct_menu.visible: ", construct_menu.visible)
		if construct_menu.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pass
	pass

func _process(_delta):
	#print("get_process_mode: ",get_process_mode())
	if ray_cast_3d.is_colliding():
		var pos = ray_cast_3d.get_collision_point()# global position
		tmp_ph.global_position = pos + Vector3(0,0.5,0)
		if Input.is_action_pressed("construct") and isPlace:
			place_item(pos)
			
		pass
	pass
	
func place_item(pos):
	create_timer.start()
	isPlace = false
	var item = placeitem.instantiate()
	#get_node("/root/main").add_child.call_deferred(item)
	get_node("/root/main/NavigationRegion3D").add_child(item)#note need be nav mesh to work
	item.global_position = pos
	get_tree().call_group("navmesh","update_navigation_mesh")
	
func _on_create_timer_timeout():
	isPlace = true
	pass
	
func selectItem(_name):
	print("_name: ", _name)
	var node_exist = get_node_or_null(tmp_ph.get_path())
	if _name == "wall":
		print("WALL")
		
		if node_exist:
			print("WALL queue_free")
			node_exist.queue_free()
		tmp_ph = ph_wall.instantiate()
		get_node("/root/main").add_child(tmp_ph)
		placeitem = wall
	if _name == "turret":
		print("TURRET")
		if node_exist:
			node_exist.queue_free()
		tmp_ph = ph_turret.instantiate()
		get_node("/root/main").add_child(tmp_ph)
		placeitem = turret
	pass

func _on_btn_wall_pressed():
	selectItem("wall")
	pass

func _on_btn_gate_pressed():
	selectItem("gate")
	pass

func _on_btn_turret_pressed():
	selectItem("turret")
	pass
