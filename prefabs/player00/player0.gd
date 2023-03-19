extends CharacterBody3D
# https://github.com/brannotaylor/3D-Ladder-Tutorial
signal health_change(health_value)

#inventory stuff
@export var inventory_data: InventoryData
signal toggle_inventory()
@onready var interact_ray = $Camera3D/InteractRay


## ===========

@onready var camera = $Camera3D
#@onready var anim_player = $AnimationPlayer
#@onready var muzzle_flash = $Camera3D/gun/MuzzleFlash
@onready var raycast = $Camera3D/RayCast3D

@onready var RightHand = $Camera3D/RightHand
#@onready var IPlaceHolder = preload("res://prefabs/prototype_build/build_tool.tscn")
#@onready var IPlaceHolder = preload("res://prefabs/prototype_projectile/prototype_gun_01.tscn")
@export var IPlaceHolder:PackedScene
@export var preloadtool:bool = false

@export var health = 3
@export var max_health = 3
#editor
#@export var isMove:bool = false
#@onready var isMove:bool = false
var isMove:bool = false

@export var enable_fall = true

@export var SPEED = 10.0
@export var CLIMB_SPEED = 4.0
@export var aceel = 10
@export var JUMP_VELOCITY = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 20

var ladder_array = []

enum State {
	NORMAL,
	LADDER,
}
var current_state = State.NORMAL

#@rpc("call_remote")
@rpc("call_local")
func set_auth():
	set_multiplayer_authority(str(name).to_int())
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true;
	pass

func _enter_tree():
	#print("is_server: ", multiplayer.is_server())
	#print("set_multiplayer_authority: ", name)
	#set_multiplayer_authority(str(name).to_int())
	#print("PEER ID: ",name)
	#rpc("local_spawn_tool")#nope
	pass
	
func _ready():
	#if not is_multiplayer_authority(): return
	#print("HELL INPUT?")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true;
	local_spawn_tool()
	pass
	
func my_spawn_tool():
	if IPlaceHolder:
		var mytool = IPlaceHolder.instantiate()
		#var name_id = mytool.name +"_"+ Helper.generate_random_numbers()
		#mytool.name = 
		#mytool.set_multiplayer_authority(str(name).to_int())
		RightHand.add_child(mytool)
	pass
	
@rpc("call_local")
func local_spawn_tool():
	if IPlaceHolder:
		var mytool = IPlaceHolder.instantiate()
		RightHand.add_child(mytool)
	pass
	
# https://docs.godotengine.org/en/stable/classes/class_nodepath.html
@rpc("any_peer")
func spawn_tool():
	if IPlaceHolder:
		var mytool = IPlaceHolder.instantiate()
		RightHand.add_child(mytool)
	pass

func _unhandled_input(event):
	#if not is_multiplayer_authority(): return
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
		
	if Input.is_action_just_pressed("interact"):
		interact()
		pass

	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		camera.rotate_x(-event.relative.y * 0.005)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func interact()->void:
	if interact_ray.is_colliding():
		#print("interact with ", interact_ray.get_collider())
		interact_ray.get_collider().player_interact()
	pass

func get_drop_position()->Vector3:
	var direction = -camera.global_transform.basis.z
	return camera.global_position + direction
	#pass


func _physics_process(delta):
	#if not is_multiplayer_authority(): return
	
	#if camera:
		#print("camera y:",camera.rotation_degrees.x)
		# postive for look up
		# negtive for look down
	
	# LADDER
	if current_state == State.LADDER:
		velocity.y = 0
		var direction  = Vector3.ZERO
		var h_rot = global_transform.basis.get_euler().y
		#var h_rot = global_transform.basis.get_euler().x
		#var h_rot = global_transform.basis.y
		#print("h_rot: ", rad_to_deg(h_rot))
		#print("h_rot: ", h_rot)
		var f_input = Input.get_action_strength("back") - Input.get_action_strength("forward")
		var h_input = Input.get_action_strength("right") - Input.get_action_strength("left")
		direction = Vector3(h_input, 0.0, f_input).rotated(Vector3.UP,h_rot).normalized()
		#var input_dir = Input.get_vector("left", "right", "up", "down")
		#direction = (transform.basis * Vector3(0, input_dir.y * -1, 0)).normalized()
		if f_input: #make sure the there movement for going up or down.
			if camera.rotation_degrees.x > 0:
				direction.y = 1
			else:
				direction.y = -1
		velocity = direction * CLIMB_SPEED
		#print("POS Y:",input_dir.y)
		#if  input_dir.y > 0 and is_on_floor(): #check if player touch ground and exit
			#current_state = State.NORMAL
		if Input.is_action_just_pressed("jump"): #exit to normal
			current_state = State.NORMAL
		
		#if not is_on_floor():

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if current_state == State.NORMAL:
		# Add the gravity.
		if not is_on_floor():
			if enable_fall:
				velocity.y -= gravity * delta	
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var input_dir = Input.get_vector("left", "right", "up", "down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			#starting speed
			velocity.x = lerp(velocity.x, direction.x * SPEED, aceel * delta)
			velocity.z = lerp(velocity.z, direction.z * SPEED, aceel * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			
		if input_dir != Vector2.ZERO and is_on_floor():
			isMove = true
		else:
			isMove = false

	move_and_slide()
	#Exit Game
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
@rpc("any_peer")
func receive_damage():
	health -= 1
	if health <= 0:
		health = 3
		position = Vector3.ZERO;
	health_change.emit(health)
	

