extends Area3D

# Note layer mesh by 2 since multiplayer conflict collision

# player
# layer [0] [x] .. 32
# mask [x] [0] .. 32

# ladder
# layer [1] [0] .. 32
# mask [0] [x] .. 32

func _on_body_entered(body):
	print("ENTER LADDER")
	print("GROUPS:", body.get_groups())
	if body.is_in_group("Player"):
		print("PLAYER ENTER LADDER")
		body.ladder_array.append(self)
		body.current_state = body.State.LADDER
	pass

func _on_body_exited(body):
	print("EXIT LADDER")
	if body.is_in_group("Player"):
		body.ladder_array.erase(self)
		if body.ladder_array.size() == 0:
			body.current_state = body.State.NORMAL
	pass
