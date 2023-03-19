extends ItemData
class_name ItemDataConsumbalbe

@export var heal_value: int

func use(target)->void:
	# heal the player
	if heal_value != 0:
		target.heal(heal_value)
	#pass
