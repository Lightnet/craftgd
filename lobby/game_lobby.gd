extends PanelContainer
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#signals
# 

@onready var UIPlayerlist = $VBoxContainer/HBC_Content/VBoxContainer2/PlayerList/VBC_Players
@onready var UIPlayerName = $VBoxContainer/HBoxContainer/LPlayerName2

var UIPlayerData = preload("res://lobby/lobby_player_row01.tscn")

var playercount = 0
var oldplayercount = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#getPlayerList()
	#setup_connection()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("Hello")
	playercount = Network.player_info.size()
	if playercount != oldplayercount: #check player list count size
		#print("UPDATE ME?????")
		oldplayercount = playercount
		getPlayerList()
	pass

func setup_connection():
	print("Hello SET LOBBY CONNECTION")
	#get_tree().peer
	
	#print("has_multiplayer_peer: ",multiplayer.has_multiplayer_peer())
	#if multiplayer.has_multiplayer_peer() == true:
		#multiplayer.peer_connected.connect(_player_connected)
		#multiplayer.peer_disconnected.connect(_player_disconnected)
	pass

func _player_connected(_id):
	#update player list
	print("LOBBY ADDED ID?", _id)
	getPlayerList()

func _player_disconnected(_id):
	#update player list
	getPlayerList()

#@rpc("any_peer")
func getPlayerList():
	if UIPlayerlist == null:
		return
	#playerlist.queue_free()
	for n in UIPlayerlist.get_children():
		UIPlayerlist.remove_child(n)
		n.queue_free()
	
	var player_row = UIPlayerData.instantiate()
	player_row.get_node("LPlayerName").text = Network.my_info["name"]
	UIPlayerName.text = Network.my_info["name"]
	UIPlayerlist.add_child(player_row)
	
	var player_info = Network.player_info
	for p in player_info:
		var player_row1 = UIPlayerData.instantiate()
		player_row1.get_node("LPlayerName").text = player_info[p]["name"]
		UIPlayerlist.add_child(player_row1)
		
		print("player_info >>:", p)
		pass
	print("player list...")

func _on_btn_redresh_players_pressed():
	getPlayerList()
	#rpc("getPlayerList")
	pass

func _on_visibility_changed():
	print("_on_visibility_changed")
	if visible == true:
		setup_connection()
		getPlayerList()
	pass


func _on_btn_start_game_pressed():
	if is_multiplayer_authority():
		print("AUTH HELLO")
	else:
		print("NOT AUTH")
	pass # Replace with function body.
