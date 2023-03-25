@tool #note in editor it need to reload if script edit
extends Node3D

func _ready():
	$Armature/Skeleton3D/LegIK.start(false)
	pass 

#func _process(delta):
	#pass
