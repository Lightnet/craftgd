extends Node3D

@onready var ray_cast_3d = $RayCast3D

@export var ph = preload("res://prefabs/prototyping/placeholders/ph_light_cube.tscn")
var tmp_ph
@export var placeitem = preload("res://prefabs/prototype/turret01/turret_01.tscn")
@onready var create_timer = $CreateTimer

var isPlace:bool = true

func _ready():
	tmp_ph = ph.instantiate()
	get_node("/root/main").add_child.call_deferred(tmp_ph)
	pass

func _exit_tree():
	if tmp_ph:
		tmp_ph.queue_free()
	pass

func _process(_delta):
	
	if ray_cast_3d.is_colliding():
		var pos = ray_cast_3d.get_collision_point()# global position
		tmp_ph.global_position = pos + Vector3(0,0.5,0)
		if Input.is_action_pressed("construct") and isPlace:
			place_item(pos + Vector3(0,0.5,0))
			
		pass
	pass
	
func place_item(pos):
	create_timer.start()
	isPlace = false
	var item = placeitem.instantiate()
	get_node("/root/main").add_child.call_deferred(item)
	item.global_position = pos
	
	

func _on_create_timer_timeout():
	isPlace = true
	pass 
