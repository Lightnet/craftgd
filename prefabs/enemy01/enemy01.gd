extends CharacterBody3D

@onready var HealthBar3D = $HealthBar3D
@onready var navigation_agent_3d = $NavigationAgent3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var health = 10
var max_health = 10

func _ready():
	HealthBar3D.update_health(10,max_health)
	pass

func _process(_delta):
	#test
	#health-=1
	#if health <= 0:
		#health = 100
	HealthBar3D.update_health(health,max_health)
	
	if health <= 0:
		queue_free()
	pass

func _physics_process(delta):
	if not is_multiplayer_authority(): return
	# Add the gravity.
	
	var current_location = global_transform.origin
	var next_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	#velocity = new_velocity
	velocity = velocity.move_toward(new_velocity, 0.25)
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func update_target_location(target_location):
	#print("target: ", target_location)
	navigation_agent_3d.set_target_position(target_location)
	pass

func _on_navigation_agent_3d_target_reached():
	print("in range")
	pass

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, 0.25)
	#move_and_slide()
	pass # Replace with function body.
