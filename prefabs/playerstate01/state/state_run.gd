# Run.gd
extends PlayerState

func enter(_msg := {}) -> void:
	print("ENTER STATE: ", name)
	player.state = player.States.ON_GROUND

func handle_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		#print("JUMP>>")
		state_machine.transition_to("Air", {do_jump = true})
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * 0.005)
		player.camera.rotate_x(-event.relative.y * 0.005)
		player.camera.rotation.x = clamp(player.camera.rotation.x, -PI/2, PI/2)
	pass

func physics_update(delta: float) -> void:
	
	if player.state == player.States.LADDER:
		state_machine.transition_to("Ladder")
		return
	
	# Notice how we have some code duplication between states. That's inherent to the pattern,
	# although in production, your states will tend to be more complex and duplicate code
	# much more rare.
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta
	#print("input_dir: ",input_dir)
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#print("direction: ", direction)
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction.x * player.SPEED, player.aceel * delta)
		player.velocity.z = lerp(player.velocity.z, direction.z * player.SPEED, player.aceel * delta)
	else:
		#print("player: ", player)
		#player.velocity.x = player.move_toward(player.velocity.x, 0, player.SPEED)
		#player.velocity.z = player.move_toward(player.velocity.z, 0, player.SPEED)
		player._move_toward()
		#pass
	
	if is_equal_approx(input_dir.x, 0.0) and is_equal_approx(input_dir.y, 0.0):
		state_machine.transition_to("Idle")
		
	player.move_and_slide()
