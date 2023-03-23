# Air.gd
extends PlayerState

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	print("ENTER STATE: ", name)
	player.state = player.States.IN_AIR
	if msg.has("do_jump"):
		player.velocity.y = player.JUMP_VELOCITY
		player.move_and_slide() #need this to update pos

func handle_input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * 0.005)
		player.camera.rotate_x(-event.relative.y * 0.005)
		player.camera.rotation.x = clamp(player.camera.rotation.x, -PI/2, PI/2)
	pass

func physics_update(delta: float) -> void:
	# Horizontal movement.
	#print("UPDATE")
	#var input_direction_x: float = (
		#Input.get_action_strength("right")
		#- Input.get_action_strength("left")
	#)
	
	#player.velocity.x = player.speed * input_direction_x
	#player.velocity.x = player.SPEED * input_direction_x
	#print("player: ", player)
	if player.state == player.States.LADDER:
		state_machine.transition_to("Ladder")
		return
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction.x * player.SPEED, player.aceel * delta)
		player.velocity.z = lerp(player.velocity.z, direction.z * player.SPEED, player.aceel * delta)
	else:
		#print("player: ", player)
		#player.velocity.x = player.move_toward(player.velocity.x, 0, player.SPEED)
		#player.velocity.z = player.move_toward(player.velocity.z, 0, player.SPEED)
		player._move_toward()
		pass
	
	# Vertical gravity.
	player.velocity.y -= player.gravity * delta
	
	#print("input_direction_x: ", input_direction_x)
	
	# Landing.
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0) and is_equal_approx(player.velocity.z, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	player.move_and_slide() #need this to update pos
