# https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
extends CharacterBody3D
class_name Player

# An enum allows us to keep track of valid states.
enum States {
	ON_GROUND, 
	IN_AIR, 
	GLIDING
}

# With a variable that keeps track of the current state, we don't need to add more booleans.
var state: int = States.ON_GROUND

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(_delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * _delta
	#move_and_slide()# need this
	"""
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	"""
	pass
