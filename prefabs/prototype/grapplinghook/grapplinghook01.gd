extends Node3D
# https://www.youtube.com/watch?v=q1TN649r8XQ

var grapping = false
var hookpoint = Vector3()
var hookpoint_get = false

@onready var grapplecast = $"../../RayCast3D2"
@onready var body = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#grapple()
	pass

func _physics_process(_delta):
	grapple()
	pass

func grapple():
	if Input.is_action_just_pressed("ability"):
		#print("grapping")
		if grapplecast.is_colliding():
			#print("hit?")
			if not grapping:
				grapping = true
	if grapping:
		#body.fall.y = 0
		body.enable_fall = false
		if not hookpoint_get:
			hookpoint = grapplecast.get_collision_point()
			var normal_point = grapplecast.get_collision_normal()
			if normal_point.y >= 1.0:
				hookpoint = hookpoint + Vector3(0,2.25,0)
			if normal_point.y <= 1.0:
				hookpoint = hookpoint - Vector3(0,2.25,0)
			#print("hookpoint: ",hookpoint)
			hookpoint_get = true
		#print("LEN", hookpoint.distance_to(body.transform.origin))
		if hookpoint.distance_to(body.transform.origin) > 1.0:
			#print("hook?")
			if hookpoint_get:
				body.transform.origin = lerp(body.transform.origin, hookpoint, 0.05)
		else:
			grapping = false
			hookpoint_get = false
			body.enable_fall = true
	#if head.is_colliding(): #raycast
		#grapping = false
		#hookpoint_get = false
		#body.enable_fall = true
		#body.global_translate(Vector3(0,-1,0))
	pass

