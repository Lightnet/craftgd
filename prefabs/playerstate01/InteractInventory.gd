extends Node
# collision mask [ 3 ]
@onready var interact_ray = $"../../Camera3D/InteractRay"

#func _ready():
	#pass

#func _process(_delta):
	#pass

#need to handle input checks.
func _unhandled_input(_event):
	if Input.is_action_just_pressed("interact"):
		interact()
		pass

func interact()->void:
	if interact_ray.is_colliding():
		#print("interact with ", interact_ray.get_collider())
		interact_ray.get_collider().player_interact()
	pass
