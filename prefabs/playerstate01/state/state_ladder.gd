
# Idle.gd
extends PlayerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	player.state = player.States.LADDER
	#print("ENTER IDLE STATE")
	#print("_msg: ",_msg)
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.velocity = Vector3.ZERO

func handle_input(event):
	#print("event")
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * 0.005)
		player.camera.rotate_x(-event.relative.y * 0.005)
		player.camera.rotation.x = clamp(player.camera.rotation.x, -PI/2, PI/2)

func update(_delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	#print("owner: ", owner)
	#if not owner.is_on_floor():
		#state_machine.transition_to("Air")
		#return

	#if Input.is_action_just_pressed("jump"):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		#print("JUMP?")
		#state_machine.transition_to("Air", {do_jump = true})
		
	#elif Input.is_action_pressed("left")	\
		#or Input.is_action_pressed("right") \
		#or Input.is_action_pressed("forward") \
		#or Input.is_action_pressed("back"):
		#print("MOVE?")
		#state_machine.transition_to("Run")
		
		
	pass
