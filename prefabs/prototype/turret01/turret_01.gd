extends Node3D


@onready var base = $base
@onready var pitch = $base/MeshInstance3D/MeshInstance3D/Node3D
@onready var firepoint = $base/MeshInstance3D/MeshInstance3D/Node3D/pitchmesh/MeshInstance3D/firepoint

@export var target = Node3D

@export var rotation_speed = 0.1

func _ready():
	pass # Replace with function body.

func _process(_delta):
	
	#if target:
		#var dir = target.global_position - global_position
		#var difference:Vector3 = dir.angle() - rotation
		#print("dir: ",dir)
		
		#look_at(target, Vector3.UP)
		
		#self.rotation_degrees.x = clamp(rotation_degrees.x, -5, 80)
		#self.rotation_degrees.y = clamp(rotation_degrees.x, -5, 80)
		
		
		#if difference != Vector3.ZERO:
			#rotation = lerp(rotation, dir.angle(), rotation_speed)
			#rotation = rotation + (difference / abs(difference) * rotation_speed)
		#pass
	
	pass
