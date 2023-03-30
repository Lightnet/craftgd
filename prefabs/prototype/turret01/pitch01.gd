extends Node3D

@onready var base = $"../../../.."

func _ready():
	pass 

func _process(_delta):
	
	if base.isTarget:
		var target = base.target
		#var dir = target.global_position - global_position
		#var difference:Vector3 = dir.angle() - rotation
		#print("dir: ",dir)
		#if not target:
		look_at(target.global_position, Vector3.UP)
		
		self.rotation_degrees.x = clamp(rotation_degrees.x, -5, 80) #ptich
		self.rotation_degrees.y = base.rotation_degrees.y #fixed
		
		
		#if difference != Vector3.ZERO:
			#rotation = lerp(rotation, dir.angle(), rotation_speed)
			#rotation = rotation + (difference / abs(difference) * rotation_speed)
		#pass
	
	pass
