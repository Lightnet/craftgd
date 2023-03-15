@tool
extends Node3D

@export_node_path("Node3D") var step_target_path
@onready var step_target = get_node(step_target_path)

@export var step_distance:float = 5

func _ready():
	pass

func _process(delta):
	var dist := global_position.distance_to(step_target.global_position)
	if dist > step_distance:
		tween_step(step_target.global_position)
	pass

func tween_step(target_pos:Vector3):
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(self,"global_position:x", target_pos.x, 0.25)
	tween.tween_property(self,"global_position:z", target_pos.z, 0.25)
	tween.tween_property(self,"global_position:y", target_pos.y + 1.5, 0.15)
	tween.set_parallel(false)
	tween.tween_property(self,"global_position:y", target_pos.y + 1.5, 0.15)
