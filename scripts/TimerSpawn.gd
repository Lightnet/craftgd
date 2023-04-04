extends Node3D

@export var entity:PackedScene = null
@export var target:Node3D = null
@onready var timer = $"../TimeSpawner/Timer"

var spawn_entity:Node3D = null

var isSpawn:bool = true

func _physics_process(_delta):
	if isSpawn:
		isSpawn=false
		timer.start()
		spawnEntity()
	pass
	
func spawnEntity():
	spawn_entity = entity.instantiate()
	get_node("/root/main").add_child(spawn_entity)
	spawn_entity.global_position = global_position
	if target:
		spawn_entity.update_target_location(target.global_transform.origin)
	
	#if not spawn_entity:
		#spawn_entity = entity.instantiate()
		#get_node("/root/main").add_child(spawn_entity)
		#spawn_entity.global_position = global_position
		#if target:
			#spawn_entity.update_target_location(target.global_transform.origin)
	pass

func _on_timer_timeout():
	isSpawn=true
	pass
