extends Node3D
class_name Weapon

@export var isLocked:bool = false
@export var projectile:NodePath
@export var isAnimationFire:bool = false
@export var isTimerFire:bool = false

enum TYPES{
	MELEE,
	GUN,
	DEPLOY,
	THROW
}


func fire():
	pass
	
func altFire():
	pass
	
func reload():
	pass

#func _ready():
	#pass
	
#func _process(delta):
	#pass
