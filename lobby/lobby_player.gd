extends HBoxContainer

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

var playerid = 1

# https://godotengine.org/qa/13795/there-disconnect-player-joined-networkedmultiplayerenet

func _on_btn_kick_pressed():
	print("player ID", playerid)
	if is_multiplayer_authority():
		if playerid != 1:
			print("CAN BE KICKED", playerid)
			multiplayer.multiplayer_peer.disconnect_peer(playerid)
	else:
		print("No Permission")
	pass # Replace with function body.
