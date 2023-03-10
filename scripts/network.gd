extends Node

var HOST = "localhost"
var PORT = 9999
var PLAYERS = 1
var isupnp = false
var headless = false

# Player info, associate ID to data, map list
var player_info = {}

# Info we send to other players
var my_info = { name = "John Doe", favorite_color = Color8(255, 0, 255) }

#const Player = preload("res://prefabs/players/player.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	
func setPlayerName(_name):
	my_info["name"] = _name

func server_host():
	var enet_peer = ENetMultiplayerPeer.new()
	#print("PORT: ",str(PORT), "SERVER ADDRESS: ", str(HOST))
	enet_peer.create_server(int(PORT), PLAYERS)
	if enet_peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)
	#print("game server")
	if isupnp:
		upnp_setup()
	
func client_join():
	#main_menu.hide()
	#hud.show()
	var enet_peer = ENetMultiplayerPeer.new()
	#print("PORT: ",str(PORT), "SERVER ADDRESS: ", str(HOST))
	enet_peer.create_client(HOST,PORT)
	#print("enet_peer.get_connection_status(): ", enet_peer.get_connection_status())
	if enet_peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return false
	#print("Client STATUS: ", enet_peer.get_connection_status())
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)
	multiplayer.server_disconnected.connect(_server_disconnect)
	#print("client")
	return true

func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_player", my_info)

func _player_disconnected(id):
	player_info.erase(id) # Erase player from info.
	#var player = get_node_or_null(str(id))
	
	#get node from main match path of the player prefab spawn
	var player = get_node("/root/Main").get_node_or_null(str(id))
	#print("PLAYER DISCONNECT: ", id)
	#print("PLAYER: ", player)
	if player:
		player.queue_free()
		
func _server_disconnect():
	var node_main = get_node_or_null("/root/Main/CanvasLayer/MainMenu")
	if node_main:
		node_main.return_mainmenu()
	pass

@rpc("any_peer")
func register_player(info):
	# Get the id of the RPC sender.
	#var id = get_tree().get_rpc_sender_id()
	var id = get_tree().get_multiplayer().get_remote_sender_id()
	# Store the info
	player_info[id] = info
	#print("info:>> ",info)

func upnp_setup():
	var upnp = UPNP.new()
	
	var discover_result = upnp.discover()
	assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Discover Failed! Error %s" % discover_result)
		
	assert(upnp.get_gateway() and upnp.get_gateway().is_valid_gateway(), \
		"UPNP Invalid Gateway")
	
	var map_result = upnp.add_port_mapping(PORT)
	assert(map_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Port Mapping Failed! Error %s" % discover_result)
	
	print("Syccess! Join Address: %s" % upnp.query_external_address())
