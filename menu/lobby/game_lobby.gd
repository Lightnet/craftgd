extends PanelContainer
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#signals
# https://www.reddit.com/r/godot/comments/qhbi8y/how_to_scroll_a_scrollcontainer_to_the_bottom/
# 

@onready var UIPlayerlist = $VBoxContainer/HBC_Content/VBoxContainer2/PlayerList/VBC_Players
@onready var UIPlayerName = $VBoxContainer/HBoxContainer/LPlayerName2
@onready var UIChatMessages = $VBoxContainer/HBC_Content/VBoxContainer/SC_Chat/VBC_Messages
@onready var MenuLobby = $"."
@onready var HUD = $"../HUD"
#@onready var EntityPlayers = $"../../world/players"
#@onready var EntityPlayers = $"../../"
@onready var EntityPlayers = $"../.."

@onready var health_bar =  $"../HUD/AspectRatioContainer/HealthBar"

@onready var scrollbar_msg = $VBoxContainer/HBC_Content/VBoxContainer/SC_Chat
@onready var vmessages = $VBoxContainer/HBC_Content/VBoxContainer/SC_Chat/VBC_Messages

var UIPlayerData = preload("res://menu/lobby/lobby_player_row01.tscn")

var UIChatMessage = preload("res://menu/lobby/lobby_player_message.tscn")

#need to config for server current local
var load_map = "res://maps/prototype01.tscn"
var playercount = 0
var oldplayercount = 0
var max_scroll_length = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
	#getPlayerList()
	#scrollbar_messages.connect("changed", scroll_to_bottom)
	#max_scroll = scrollbar_messages.max_value 
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("Hello")
	playercount = Network.player_info.size()
	if playercount != oldplayercount: #check player list count size
		#print("UPDATE ME?????")
		oldplayercount = playercount
		getPlayerList()
	
	update_scroll_msg()
	pass

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
		player_row1.playerid = p
		UIPlayerlist.add_child(player_row1)
		#print("player_info >>:", p)
		#pass
	#print("player list...")

func _on_btn_redresh_players_pressed():
	getPlayerList()
	#rpc("getPlayerList")
	pass

func _on_btn_start_game_pressed():
	#print("CHECKING...")
	if is_multiplayer_authority():
		#print("Server AUTH")
		setup_host() 
		#rpc_id(1,"setup_host")#fail
		#rpc("setup_host")#
	else:
		print("NOT AUTH")
	pass # Replace with function body.

@rpc("any_peer","unreliable")
func ChatMessageAppend(msg):
	#print("msg",msg )
	var peer_id = self.multiplayer.get_remote_sender_id()
	var playername = ""
	if Network.player_info[peer_id] == null:
		return
	playername = Network.player_info[peer_id]["name"]
	#print("peer_id: ", peer_id)
	var player_msg = UIChatMessage.instantiate()
	player_msg.get_node("LPlayerName").text = playername
	player_msg.get_node("Message").text = msg
	UIChatMessages.add_child(player_msg)
	#update_scroll_msg()
	pass

func _on_le_chat_message_text_submitted(new_text):
	#print("CHAT TEXT INPUT ", new_text)
	#var peer_id = get_tree().get_multiplayer().get_unique_id()
	#print("peer_id", peer_id)
	var playername = Network.my_info["name"]
	#var playerlist = Network.player_info
	#print("PLAYERS:", playerlist)
	#if Network.player_info[peer_id] == null:
		#return
	var player_msg = UIChatMessage.instantiate()
	player_msg.get_node("LPlayerName").text = playername
	player_msg.get_node("Message").text = new_text
	UIChatMessages.add_child(player_msg)
	#update_scroll_msg()
	#boardcast all but not self
	rpc("ChatMessageAppend",  new_text)
	pass

func update_scroll_msg(): #loop update
	#await get_tree().create_timer(500).timeout
	
	if scrollbar_msg: #check if node exist
		var scrollbar = scrollbar_msg.get_v_scroll_bar()
		if max_scroll_length != scrollbar.max_value: #check if scroll diff
			max_scroll_length = scrollbar.max_value
			scrollbar_msg.scroll_vertical = scrollbar.max_value
	pass

func update_health_bar(health_value):
	health_bar.value = health_value

func _on_multiplayer_spawner_spawned(node):
	if node.is_multiplayer_authority():
		node.health_change.connect(update_health_bar)

# set up host map and player
func setup_host():
	show_hud()
	if is_multiplayer_authority():
		#boardcast to other remote player 
		#rpc("pre_configure_game")
		#rpc_id(1,"spawn_map") #nope #current host
		rpc("spawn_map")
		#rpc("setup_players")
		setup_players()
		rpc("show_hud")
	pass
	
# HUD
@rpc("call_remote")
func show_hud():
	MenuLobby.hide()
	HUD.show()
	pass

@rpc("call_remote")
func spawn_map():
	
	#var selfPeerID = get_tree().get_multiplayer().get_unique_id()
	# Load world
	var world = load(load_map).instantiate()
	get_node("/root/Main/world/level").add_child(world)
	pass

#@rpc("authority")
func setup_players():
	#print("init set up game...")
	#var treeSelfPeerID = get_tree().get_multiplayer().get_unique_id()
	#print("treeSelfPeerID: ", treeSelfPeerID)
	var selfPeerID = 1 #host id AUTH
	set_multiplayer_authority(1)
	# Load world
	#var world = preload(load_map).instantiate()
	var world = load(load_map).instantiate()
	get_node("/root/Main/world/level").add_child(world)
	
	# Load my player
	var my_player = preload("res://prefabs/player01/player.tscn").instantiate()
	my_player.set_name(str(selfPeerID))
	my_player.health_change.connect(update_health_bar)
	EntityPlayers.add_child(my_player)
	my_player.local_spawn_tool.rpc()
	my_player.spawn_tool.rpc()
	my_player.set_auth()
	
	
	# Load other players
	var player_info = Network.player_info
	var PlayerIn = preload("res://prefabs/player01/player.tscn")
	for p in player_info:
		var player = PlayerIn.instantiate()
		player.set_name(str(p))
		EntityPlayers.add_child(player)
		player.my_spawn_tool() # host spawn tool
		player.spawn_tool.rpc() # boardcast
		#player.set_multiplayer_authority(p)
		#player.set_auth.rpc() # boardcast
		pass
	pass

#init setup game config
@rpc("call_remote")
func pre_configure_game():
	#get_tree().set_pause(true) # Pre-pause
	MenuLobby.hide()
	HUD.show()
	#print("init set up game...")
	
	# Load world
	var world = load(load_map).instantiate()
	get_node("/root/Main/world/level").add_child(world)
	
	# Load my player
	#var selfPeerID = get_tree().get_multiplayer().get_unique_id()
	#var my_player = preload("res://prefabs/players/player.tscn").instantiate()
	#my_player.set_name(str(selfPeerID))
	##my_player.set_network_master(selfPeerID) # Will be explained later
	#my_player.health_change.connect(update_health_bar)
	#get_node("/root/Main/world/players").add_child(my_player)
	#EntityPlayers.add_child(my_player)
	#add_child(my_player)
	

	#var player_info = Network.player_info
	# Load other players
	#for p in player_info:
		#var player = preload("res://prefabs/players/player.tscn").instantiate()
		#player.set_name(str(p))
		#player.set_network_master(p) # Will be explained later
		#get_node("/root/Main/world/players").add_child(player)
		#EntityPlayers.add_child(player)
		#add_child(player)
		#EntityPlayers.add_child(player)
		#pass
		
	
	# Tell server (remember, server is always ID=1) that this peer is done pre-configuring.
	# The server can call get_tree().get_rpc_sender_id() to find out who said they were done.
	#if is_multiplayer_authority():
		#rpc_id(1, "done_preconfiguring")
	#rpc("done_preconfiguring")
	
	pass

var players_done = []
@rpc("call_remote")
func done_preconfiguring():
	#var who = get_tree().get_rpc_sender_id()
	#var who = get_tree().get_multiplayer().get_remote_sender_id()
	#assert(get_tree().get_multiplayer().is_server())
	#var player_info = Network.player_info
	#assert(who in player_info) # Exists
	#assert(not who in players_done) # Was not added yet
	
	#players_done.append(who)
	#if players_done.size() == player_info.size():
		#rpc("post_configure_game")
	if is_multiplayer_authority():
		rpc("post_configure_game")
	pass

@rpc("call_remote")
func post_configure_game():
	# Only the server is allowed to tell a client to unpause
	#if 1 == get_tree().get_rpc_sender_id():
	if 1 == get_tree().get_multiplayer().get_remote_sender_id():
		get_tree().set_pause(false)
		print("UN PAUSE GAME.... ")
		# Game starts now!
	pass

#END SCRIPT
