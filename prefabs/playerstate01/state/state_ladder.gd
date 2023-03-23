
# Idle.gd
extends PlayerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	print("ENTER STATE: ", name)
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.velocity = Vector3.ZERO

func handle_input(event):
	#print("event")
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * 0.005)
		player.camera.rotate_x(-event.relative.y * 0.005)
		player.camera.rotation.x = clamp(player.camera.rotation.x, -PI/2, PI/2)

func update(_delta: float) -> void:
	#print("LADDER UPDATE...")
	#if ladder count is zero return to air to check fall
	if player.ladder_array.size() == 0:
		state_machine.transition_to("Air")
		return
	var direction  = Vector3.ZERO
	var h_rot = player.global_transform.basis.get_euler().y
	#var h_rot = global_transform.basis.get_euler().x
	#var h_rot = global_transform.basis.y
	#print("h_rot: ", rad_to_deg(h_rot))
	#print("h_rot: ", h_rot)
	var f_input = Input.get_action_strength("back") - Input.get_action_strength("forward")
	var h_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction = Vector3(h_input, 0.0, f_input).rotated(Vector3.UP,h_rot).normalized()
	if f_input: #make sure the there movement for going up or down.
		if player.camera.rotation_degrees.x > 0:
			direction.y = 1
		else:
			direction.y = -1
	player.velocity = direction * player.CLIMB_SPEED
	#print("POS Y:",input_dir.y)
	#print("direction: ", direction)
	#enter and exit when point down
	if direction.y < 0 and player.is_on_floor(): #check if player touch ground and exit
		state_machine.transition_to("Idle")
		#print("FLOOR!")
		pass
	if Input.is_action_just_pressed("jump"): #exit to normal
		state_machine.transition_to("Air")
	player.move_and_slide()
	pass
