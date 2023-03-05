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
var PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

var characters = 'abcdefghijklmnopqrstuvwxyz'

func _ready():
	var new_word = generate_word(characters, 11)
	print(new_word)
	IPlayerName.text = new_word

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
	
	LNetworkType.text= "Server"
	LHUDNetworkType.text= "Server"
	LHUDPlayerName.text = IPlayerName.text
	#print("server")
	#upnp_setup()

func _on_join_button_pressed():
	main_menu.hide()
	#hud.show()
	Network.setPlayerName(IPlayerName.text)
	Network.client_join()
	menu_lobby.show()
	
	var node = Node.new() #for handle remote debug
	node.name = "NodeClient"
	get_node("/root/Main").add_child(node)
	
	LNetworkType.text= "Client"
	LHUDNetworkType.text= "Client"
	LHUDPlayerName.text = IPlayerName.text
	#print("client")
	
func return_mainmenu():
	#print("server disconnected!", peer_id)
	hud.hide()
	menu_lobby.hide()
	main_menu.show()
	#set network null
	#get_tree().network_peer = null
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#pass

func update_health_bar(health_value):
	health_bar.value = health_value

func _on_multiplayer_spawner_spawned(node):
	if node.is_multiplayer_authority():
		node.health_change.connect(update_health_bar)

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
