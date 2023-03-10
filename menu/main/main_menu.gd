extends Node

func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

@onready var main_menu = $"."
@onready var menu_lobby = $"../Lobby"
@onready var menu_settings = $"../MainSettings"

@onready var address_entry = $MarginContainer/VBoxContainer/AddressEntry
@onready var hud = $"../HUD"
@onready var IPlayerName = $MarginContainer/VBoxContainer/IUserName 
@onready var LNetworkType = $"../Lobby/VBoxContainer/HBoxContainer/LNetworkType"
@onready var LHUDNetworkType = $"../HUD/AspectRatioContainer/LHUDNetworkType"
@onready var LHUDPlayerName = $"../HUD/AspectRatioContainer/LHUDPlayerName"

@onready var LEPort = $MarginContainer/VBoxContainer/PortEntry
@onready var CBUPNP = $MarginContainer/VBoxContainer/HBoxContainer/CBtnUPNP
@onready var LineEditRegEx = RegEx.new()
var old_text = ""

func _ready():
	var new_word = Helper.generate_random_name(11)
	#print(new_word)
	IPlayerName.text = new_word
	LineEditRegEx.compile("^[0-9.]*$")
	
	LEPort.text = str(Network.PORT)
	if Network.isupnp:
		CBUPNP.button_pressed = true
	else:
		CBUPNP.button_pressed = false
	
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
# network call from node path
func return_mainmenu():
	#print("server disconnected!", peer_id)
	hud.hide()
	menu_lobby.hide()
	main_menu.show()
	#set network null
	#get_tree().network_peer = null
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#pass

func _on_btn_random_name_pressed():
	var new_word = Helper.generate_random_name(11)
	#print(new_word)
	IPlayerName.text = new_word

# https://godotengine.org/qa/112648/lineedit-make-sure-only-getting-number-input-least-validate
# https://godotengine.org/qa/86533/textedit-caret-position-there-ignore-tab-enter-indentations
func _on_port_entry_text_changed(new_text):
	if LineEditRegEx.search(new_text):
		old_text = str(new_text)
		Network.PORT = int(new_text)
	else:
		LEPort.text = old_text
		#LEPort.insert_text_at_caret(old_text)
		#LEPort.set_cursor_position(LEPort.text.length())
		#LEPort.set_c

#node multiplayerspawner
func _on_multiplayer_spawner_spawned(data):
	print("_on_multiplayer_spawner_spawned....", data)
	pass

func _on_c_btn_upnp_toggled(button_pressed):
	print("button_pressed: ",button_pressed)
	Network.isupnp = button_pressed
	pass # Replace with function body.

#quit app
func _on_btn_quit_pressed():
	get_tree().quit()
	pass

func _on_btn_settings_pressed():
	menu_settings.show()
	pass # Replace with function body.
