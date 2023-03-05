extends Node

func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

@onready var main_menu = $CanvasLayer/MainMenu
@onready var menu_lobby = $CanvasLayer/Lobby
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry
@onready var hud = $CanvasLayer/HUD
@onready var health_bar =  $CanvasLayer/HUD/AspectRatioContainer/HealthBar

@onready var IPlayerName = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/IUserName 
@onready var LNetworkType = $CanvasLayer/Lobby/VBoxContainer/HBoxContainer/LNetworkType

@onready var LHUDNetworkType = $CanvasLayer/HUD/AspectRatioContainer/LHUDNetworkType
@onready var LHUDPlayerName = $CanvasLayer/HUD/AspectRatioContainer/LHUDPlayerName


const Player = preload("res://prefabs/players/player.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

var characters = 'abcdefghijklmnopqrstuvwxyz'

func _ready():
	var new_word = generate_word(characters, 11)
	print(new_word)
	IPlayerName.text = new_word
	
	pass # Replace with function body.

func generate_word(chars, length):
	var word: String = ""
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word

func _on_host_button_pressed():
	main_menu.hide()
	
	Network.setPlayerName(IPlayerName.text)
	Network.server_host()
	#hud.show()
	menu_lobby.show()
	
	var node = Node.new() #for handle remote debug
	node.name = "NodeServer"
	get_node("/root/Main").add_child(node)
	
	#enet_peer.create_server(PORT)
	#multiplayer.multiplayer_peer = enet_peer
	#multiplayer.peer_connected.connect(add_player)
	#multiplayer.peer_disconnected.connect(remove_player)
	#add_player(multiplayer.get_unique_id())
	LNetworkType.text= "Server"
	LHUDNetworkType.text= "Server"
	LHUDPlayerName.text = IPlayerName.text
	print("server")
	
	#upnp_setup()

func _on_join_button_pressed():
	main_menu.hide()
	#hud.show()
	
	Network.setPlayerName(IPlayerName.text)
	Network.client_join()
	
	menu_lobby.show()
	
	#enet_peer.create_client(address_entry.text,PORT)
	#multiplayer.multiplayer_peer = enet_peer
	#multiplayer.peer_disconnected.connect(return_menu)
	
	var node = Node.new() #for handle remote debug
	node.name = "NodeClient"
	get_node("/root/Main").add_child(node)
	
	LNetworkType.text= "Client"
	LHUDNetworkType.text= "Client"
	LHUDPlayerName.text = IPlayerName.text
	print("client")
	
func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	if player.is_multiplayer_authority():
		player.health_change.connect(update_health_bar)
		
func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()
		
func return_menu(peer_id):
	print("server disconnected!", peer_id)
	main_menu.show()
	hud.hide()
	#set network null
	get_tree().network_peer = null
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

func update_health_bar(health_value):
	health_bar.value = health_value

func _on_multiplayer_spawner_spawned(node):
	if node.is_multiplayer_authority():
		node.health_change.connect(update_health_bar)

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

func _on_btn_random_name_pressed():
	var new_word = generate_word(characters, 11)
	print(new_word)
	IPlayerName.text = new_word


func _on_btn_send_msg_pressed():
	
	rpc("SendMessage")
	pass # Replace with function body.
	

@rpc("any_peer", "unreliable")	
func SendMessage(_username, _message):
	
	print("Hello server?", get_tree().get_multiplayer().is_server())
	pass 




