# https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
extends CharacterBody3D
class_name Player

# An enum allows us to keep track of valid states.
enum States {
	IDLE,
	ON_GROUND, 
	IN_AIR, 
	GLIDING,
	LADDER,
	FLY,
}

# With a variable that keeps track of the current state, we don't need to add more booleans.
var state: int = States.ON_GROUND

#inventory stuff
@export var inventory_data: InventoryData
@export var equip_inventory_data:InventoryDataEquip
signal toggle_inventory()
#@onready var interact_ray = $Camera3D/InteractRay

#character movement settings
@export var SPEED = 5.0
@export var aceel = 10
@export var JUMP_VELOCITY = 4.5
@export var CLIMB_SPEED = 4.0

var ladder_array = []

@onready var camera = $Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	
	PlayerManager.player = self
	#need to check stuff
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _physics_process(_delta):
	"""
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * _delta
	#move_and_slide()# need this to update
	
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

func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
		
func get_drop_position()->Vector3:
	var direction = -camera.global_transform.basis.z
	return camera.global_position + direction
	#pass

#need this for state else player.move_toward error not found v4.0.1
func _move_toward():
	velocity.x = move_toward(velocity.x, 0, SPEED)
	velocity.z = move_toward(velocity.z, 0, SPEED)
	pass
