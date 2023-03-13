extends RigidBody3D
# https://www.youtube.com/watch?v=_R2KDcAp1YQ

@export var float_force := 1.0 # 3.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05

@onready var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity")

var water_height := 0.0
var submergeed := false

#func _ready():
	#pass

#func _process(delta):
	#pass
	
func _physics_process(_delta):
	submergeed = false
	var depth = water_height - global_position.y
	if depth > 0:
		#print()
		submergeed = true
		apply_central_force(Vector3.UP * float_force * gravity * depth)

func _integrate_forces(state):
	if submergeed:
		state.linear_velocity *= 1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag
