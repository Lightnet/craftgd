extends Node3D

@export var entity:PackedScene = null
@export var target:Node3D = null

var spawn_entity:Node3D = null

func _physics_process(_delta):
	
	check_Spawn()
	pass

func check_Spawn():
	if not spawn_entity:
		spawn_entity = entity.instantiate()
		get_node("/root/main").add_child(spawn_entity)
		spawn_entity.global_position = global_position
		if target:
			spawn_entity.update_target_location(target.global_transform.origin)
