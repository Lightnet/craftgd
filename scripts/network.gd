extends Node


var hostname = "localhost"
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

# Player info, associate ID to data
var player_info = {}

# Info we send to other players
var my_info = { name = "John Doe", favorite_color = Color8(255, 0, 255) }

#const Player = preload("res://prefabs/players/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	
func setPlayerName(_name):
	my_info["name"] = _name

func server_host():
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)
	
	#multiplayer.peer_connected.connect(add_player)
	#multiplayer.peer_disconnected.connect(remove_player)
	
	#add_player(multiplayer.get_unique_id())
	print("game server")
	#upnp_setup()
	
func client_join():
	#main_menu.hide()
	#hud.show()
	
	enet_peer.create_client(hostname,PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)
	#multiplayer.peer_disconnected.connect(return_menu)
	print("client")

func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_player", my_info)

func _player_disconnected(id):
	player_info.erase(id) # Erase player from info.

@rpc("any_peer")
func register_player(info):
	# Get the id of the RPC sender.
	#var id = get_tree().get_rpc_sender_id()
	var id = get_tree().get_multiplayer().get_remote_sender_id()
	# Store the info
	player_info[id] = info
	print("info:>> ",info)

	# Call function to update lobby UI here














#func add_player(peer_id):
	#var player = Player.instantiate()
	#player.name = str(peer_id)
	#add_child(player)
	#if player.is_multiplayer_authority():
		#player.health_change.connect(update_health_bar)
	#pass
		
#func remove_player(peer_id):
	#var player = get_node_or_null(str(peer_id))
	#if player:
		#player.queue_free()
		
#func return_menu(peer_id):
	#print("server disconnected!", peer_id)
	#main_menu.show()
	#hud.hide()
	#set network null
	#get_tree().network_peer = null
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#pass
