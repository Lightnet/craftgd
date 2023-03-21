# Air.gd
extends PlayerState

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	print("STATE: ", name)
	if msg.has("do_jump"):
		player.velocity.y = player.JUMP_VELOCITY

func physics_update(delta: float) -> void:
	# Horizontal movement.
	#print("UPDATE")
	var input_direction_x: float = (
		Input.get_action_strength("right")
		- Input.get_action_strength("left")
	)
	#player.velocity.x = player.speed * input_direction_x
	player.velocity.x = player.SPEED * input_direction_x
	#print("player: ", player)
	
	# Vertical movement.
	player.velocity.y -= player.gravity * delta
	
	print("input_direction_x: ", input_direction_x)
	
	# Landing.
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	player.move_and_slide() #need this to update pos
