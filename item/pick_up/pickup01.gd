extends RigidBody3D


@export var slot_data: SlotData

@onready var sprite_3d = $Sprite3D

func _ready()->void:
	sprite_3d.texture = slot_data.item_data.texture	
	#pass

func _physics_process(delta):
	sprite_3d.rotate_y(delta)

func _on_area_3d_body_entered(body):
	#print("Body Enter!")
	if body.inventory_data.pick_up_slot_data(slot_data):
		queue_free()
	#pass
