extends Node

@onready var MarkLobby = $world/M3D_Lobby
@onready var MarkLoadout = $world/M3D_Loadouts

@onready var CamLobby = $world/CameraLobby
@onready var CamLoadout = $world/CameraLoadouts

#func _ready():
	#pass

#func _process(_delta):
	#pass
	
func _on_btn_lobby_pressed():
	CamLobby.current = true
	pass

func _on_btn_loadouts_pressed():
	CamLoadout.current = true
	pass
