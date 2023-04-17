extends Node3D

@onready var base = $base
@onready var pitch = $base/MeshInstance3D/MeshInstance3D/Node3D
@onready var firepoint = $base/MeshInstance3D/MeshInstance3D/Node3D/pitchmesh/MeshInstance3D/firepoint
@onready var projectile = preload("res://prefabs/projectile/projectile01.tscn")

@onready var control = $CanvasLayer/Control

@export var target:Node3D = null
@export var isTarget:bool = false
@onready var area_3d = $Area3D

@export var rotation_speed = 0.1
@onready var fire_timer = $FireTimer
@export var bFire:bool = true

@onready var canvas_layer = $CanvasLayer

@onready var item_name = "Base Turret"
@onready var damage = 2
@onready var level = 0

@export var filter_targets = [
	"Player",
	#"Enemy",
]
@export var tagTarget = "Enemy"

var speed_dir = Vector3.ZERO
var new_speed_dir = Vector3.ZERO
var old_speed_dir = Vector3.ZERO

func _ready():
	if control:
		control.update_name(item_name)
	pass 

func _physics_process(_delta):
	
	if target:
		new_speed_dir = target.global_position
		#FOR DIR FORWARD
		speed_dir = old_speed_dir - new_speed_dir
		#print("speed_dir: ", speed_dir)
		
		#BASE
		base.look_at(target.global_position + (-speed_dir *  10), Vector3.UP)
		base.rotation_degrees.x = rotation_degrees.x
		
		#PITCH
		pitch.look_at(target.global_position, Vector3.UP)
		pitch.rotation_degrees.x = clamp(pitch.rotation_degrees.x, -5, 80) #ptich
		pitch.rotation_degrees.y = rotation_degrees.y #fixed
		old_speed_dir = new_speed_dir
		#pass
	else:
		speed_dir = Vector3.ZERO
		
	if isTarget:
		#print("fire_timer.is_stopped(): ", fire_timer.is_stopped())
		if bFire:
			fireProjectile()
			#print("FIRE??")
		pass
	pass
	
func fireProjectile():
	bFire = false
	fire_timer.start()
	var p = projectile.instantiate()
	get_node("/root").add_child(p)#depend on the order else error
	p.damage = damage
	p.set_global_rotation(firepoint.global_rotation)
	p.set_global_position(firepoint.global_position)
	p.dir = firepoint.global_transform.basis.z  
	#(firepoint.global_position - target.global_position).nor

func _on_area_3d_body_entered(body):
	#print("ENTER TARGET: ",body)
	if body.is_in_group(tagTarget) && isTarget == false:
		target = body
		isTarget=true
	pass

func _on_area_3d_body_exited(body):
	if body == target:
		isTarget = false
		target = null
	pass

func _on_fire_timer_timeout():
	bFire = true
	pass

func interact():
	print("MENU?")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	canvas_layer.visible = true
	pass

func close_menu():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	canvas_layer.visible = false
	pass

func _on_btn_close_pressed():
	close_menu()
	pass

func _on_btn_upgrade_pressed():
	damage+=5
	level+=1
	control.update_data(level, damage)
	pass
