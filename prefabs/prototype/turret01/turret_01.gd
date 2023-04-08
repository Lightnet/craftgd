extends Node3D

@onready var base = $base
@onready var pitch = $base/MeshInstance3D/MeshInstance3D/Node3D
@onready var firepoint = $base/MeshInstance3D/MeshInstance3D/Node3D/pitchmesh/MeshInstance3D/firepoint
@onready var projectile = preload("res://prefabs/projectile/projectile01.tscn")

@onready var control = $CanvasLayer/Control

@export var target = Node3D
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

func _ready():
	if control:
		control.update_name(item_name)
	pass 

func _physics_process(_delta):
	
	if isTarget:
		#print("fire_timer.is_stopped(): ", fire_timer.is_stopped())
		if bFire:
			fireProjectile()
			#print("FIRE??")
		pass
	
	#if target:
		#var dir = target.global_position - global_position
		#var difference:Vector3 = dir.angle() - rotation
		#print("dir: ",dir)
		#look_at(target, Vector3.UP)
		#self.rotation_degrees.x = clamp(rotation_degrees.x, -5, 80)
		#self.rotation_degrees.y = clamp(rotation_degrees.x, -5, 80)
		#if difference != Vector3.ZERO:
			#rotation = lerp(rotation, dir.angle(), rotation_speed)
			#rotation = rotation + (difference / abs(difference) * rotation_speed)
		#pass
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
	if body.is_in_group(tagTarget):
		target = body
		isTarget=true
	pass

func _on_area_3d_body_exited(body):
	if body == target:
		isTarget=false
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
