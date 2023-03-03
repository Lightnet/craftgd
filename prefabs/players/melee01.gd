extends Node

@onready var melee_anim = $AnimationPlayer
@onready var hitbox = $"../HitBox"
var melee_damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func melee():
	if Input.is_action_just_pressed("Fire"): 
		if not melee_anim.is_playing():
			melee_anim.play("Attack")
			melee_anim.queue("Return")
			print("Attack...")
		if melee_anim.current_animation == "Attack":
			for body in hitbox.get_overlapping_bodies():
				if body.is_in_group("Enemy"):
					body.health -= melee_damage
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	melee()
	pass
