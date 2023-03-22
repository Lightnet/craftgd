extends Area3D

#func _ready():
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_body_entered(body):
	print("Hello?", body)
	if body.is_in_group("Player"):
		print("FOUND AREA PLAYER")
	pass # Replace with function body.


func _on_area_entered(area):
	print("Hello?", area)
	pass # Replace with function body.
