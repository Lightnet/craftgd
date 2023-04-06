extends Node
# https://www.youtube.com/watch?v=qMBJaVL-vKc&t=932s

@onready var melee_anim = $MeleeWeapon/AnimationPlayer
@onready var hitbox = $MeleeWeapon/MeshInstance3D/MeshInstance3D/HitBox
var melee_damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func melee():
	if Input.is_action_just_pressed("fire"): 
		if not melee_anim.is_playing():
			hitbox.monitoring = true
			melee_anim.play("Attack")
			melee_anim.queue("Return")
			#print("Attack...")
		#if melee_anim.current_animation == "Attack":
			#for body in hitbox.get_overlapping_bodies():
				#if body.is_in_group("Enemy"):
					#body.health -= melee_damage
			#pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	melee()
	pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		hitbox.monitoring = false
	pass

func _on_hit_box_area_entered(area):#check if area node
	if area.is_in_group("Enemy"):
		print("area hit")
		area.health -= melee_damage
	pass 

func _on_hit_box_body_entered(body):#check for rig body node
	if body.is_in_group("Enemy"):
		print("body hit")
		body.health -= melee_damage
	pass
