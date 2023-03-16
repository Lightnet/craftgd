extends Node3D

@onready var raycast = $Holder/MeshInstance3D/RayCast3D
@export var prefab_decal: PackedScene

func _ready():
	pass 

func _process(_delta):
	if Input.is_action_pressed("fire"):
		if raycast.is_colliding():
			var pos = raycast.get_collision_point()
			var d = prefab_decal.instantiate()
			get_tree().get_root().add_child(d)
			d.transform.origin = pos
			
	pass
