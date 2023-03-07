extends CharacterBody3D

signal health_change(health_value)

@onready var camera = $Camera3D
#@onready var anim_player = $AnimationPlayer
#@onready var muzzle_flash = $Camera3D/gun/MuzzleFlash
@onready var raycast = $Camera3D/RayCast3D

@onready var RightHand = $Camera3D/RightHand
@onready var IPlaceHolder = preload("res://prefabs/prototype_build/build_tool.tscn")

var health = 3
#editor
#@export var isMove:bool = false
#@onready var isMove:bool = false
var isMove:bool = false

const SPEED = 10.0
const JUMP_VELOCITY = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 20

#@rpc("call_remote")
@rpc("call_local")
func set_auth():
	set_multiplayer_authority(str(name).to_int())
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true;
	pass

func _enter_tree():
	print("is_server: ", multiplayer.is_server())
	print("set_multiplayer_authority: ", name)
	set_multiplayer_authority(str(name).to_int())
	#print("PEER ID: ",name)
	#rpc("local_spawn_tool")#nope
	pass
	
func _ready():
	if not is_multiplayer_authority(): return
	#print("HELL INPUT?")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true;
	#local_spawn_tool()
	pass
	
func my_spawn_tool():
	var mytool = IPlaceHolder.instantiate()
	#var name_id = mytool.name +"_"+ Helper.generate_random_numbers()
	#mytool.name = 
	#mytool.set_multiplayer_authority(str(name).to_int())
	RightHand.add_child(mytool)
	#spawn_tool()
	#rpc("spawn_tool", str(name).to_int())
	pass
	
@rpc("call_local")
func local_spawn_tool():
	var mytool = IPlaceHolder.instantiate()
	#var name_id = mytool.name +"_"+ Helper.generate_random_numbers()
	#mytool.name = 
	#mytool.set_multiplayer_authority(str(name).to_int())
	RightHand.add_child(mytool)
	#spawn_tool()
	#rpc("spawn_tool", str(name).to_int())
	pass
	
# https://docs.godotengine.org/en/stable/classes/class_nodepath.html
@rpc("any_peer")
func spawn_tool():
	#var peer_id = multiplayer.get_remote_sender_id()
	#print("call_remote spawn_tool")
	#print("isServer: ",multiplayer.is_server())
	#print("isAuth: ",is_multiplayer_authority())
	#print("peer_id: ",peer_id)
	#print("assign_id: ",_id)
	var mytool = IPlaceHolder.instantiate()
	RightHand.add_child(mytool)
	
	
	#mytool.set_multiplayer_authority(str(name).to_int())
	#RightHand.add_child(mytool)
	#$Camera3D/RightHand.add_child(mytool)
	#print("DATA>>>: /root/Main/"+str(peer_id)+"/Camera3D/RightHand")
	#get_node("/root/Main/"+str(peer_id)+"/Camera3D/RightHand").add_child(mytool)
	#var obj = get_node("/root/Main").get_children()
	#print("obj: ", obj)
	pass

func _unhandled_input(event):
	if not is_multiplayer_authority(): return

	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		camera.rotate_x(-event.relative.y * 0.005)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if not is_multiplayer_authority(): return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if input_dir != Vector2.ZERO and is_on_floor():
		isMove = true
	else:
		isMove = false

	move_and_slide()
	
@rpc("any_peer")
func receive_damage():
	health -= 1
	if health <= 0:
		health = 3
		position = Vector3.ZERO;
	health_change.emit(health)
	
#@rpc("call_local")
#func play_shoot_effects():
	#anim_player.stop()
	#anim_player.play("shoot")
	#muzzle_flash.restart()
	#muzzle_flash.emitting = true
	
#func _on_animation_player_animation_finished(anim_name):
	#if anim_name == "shoot":
		#anim_player.play("idle")
