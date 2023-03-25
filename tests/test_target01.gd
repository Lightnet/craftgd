# https://docs.godotengine.org/en/stable/tutorials/plugins/running_code_in_the_editor.html
@tool
extends Node3D

@onready var hand = $Hand
#@export var target:Node3D
@onready var target:Node3D = $"../Target"

@onready var ray_cast_3d = $RayCast3D
@onready var contact_point = $ContactPoint

@export var pos : Vector3 =Vector3.ZERO :
	set(vec):
		pos = vec
		if hand:
			hand.look_at(vec)
			#if target:
				#print("updat post?")
				#hand.look_at(target.global_position)
			#else:
				#hand.look_at(vec)
# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		print("editor?")
		pass
	pass # Replace with function body.

func _process(_delta):
	if Engine.is_editor_hint():
		#if hand:
			#print("HAND?..", target)
			#if target:
				#hand.look_at(target.global_position)
				#print("HAND?")
		#print("hint")
		#print(ray_cast_3d)
		#print("ray_cast_3d:", ray_cast_3d.is_colliding())
		#if ray_cast_3d.is_colliding():
			#print("HIT...")
			#pos = ray_cast_3d.get_collision_point()
			#pass
		#else:
			#var point = ray_cast_3d.target_position
			#var point = ray_cast_3d.get_target_position()
			#print("point: ", point)
			#pass
		#print("pos: ", pos)
		#contact_point = pos
		pass
	if hand:
		if target:
			hand.look_at(target.global_position)
	pass

func _physics_process(_delta):
	#if hand:
		#if target:
			#hand.look_at(target.global_position)
	pass
