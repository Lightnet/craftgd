extends Node
 # https://godotengine.org/qa/12831/can-anyone-explain-to-me-unhandled-input-and-handled-input
@onready var UIChatMessage = preload("res://menu/chat/player_message.tscn")

@onready var UIChatMessages = $ScrollContainer/VBC_ChatMsg
@onready var UIScrollMessages = $ScrollContainer
@onready var UIInputChatMessage = $HBoxContainer/TE_ChatMsg
@onready var chatbox = $"."

var max_scroll_length = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

#func _unhandled_input(event):
func _input(_event):
	if chatbox:
		if Input.is_action_just_released("Comand") and chatbox.is_visible_in_tree() == true:
			#print("Here..?", chatbox.visible)
			#print("Here is_visible_in_tree?", chatbox.is_visible_in_tree())
			UIInputChatMessage.grab_focus()
		#if Input.is_action_just_released("Comand") and event.is_pressed():
			#print("CHAT???")

func _process(_delta):
	update_scroll()
	#pass

@rpc("any_peer","unreliable")
func GameChatMessageAppend(msg):
	print("msg",msg )
	var peer_id = self.multiplayer.get_remote_sender_id()
	var playername = ""
	if Network.player_info[peer_id] == null:
		return
	playername = Network.player_info[peer_id]["name"]
	print("peer_id: ", peer_id)
	var player_msg = UIChatMessage.instantiate()
	player_msg.get_node("UserName").text = playername
	player_msg.get_node("Message").text = msg
	UIChatMessages.add_child(player_msg)
	pass

func _on_te_chat_msg_text_submitted(new_text):
	var peer_id = get_tree().get_multiplayer().get_unique_id()
	
	UIInputChatMessage.release_focus()
	
	print("peer_id", peer_id)
	var playername = Network.my_info["name"]
	#var playerlist = Network.player_info
	#print("PLAYERS:", playerlist)
	#if Network.player_info[peer_id] == null:
		#return
	var player_msg = UIChatMessage.instantiate()
	player_msg.get_node("UserName").text = playername
	player_msg.get_node("Message").text = new_text
	UIChatMessages.add_child(player_msg)
	#boardcast all but not self
	rpc("GameChatMessageAppend",  new_text)
	pass

func update_scroll():
	if UIScrollMessages: #check if node exist
		var scrollbar = UIScrollMessages.get_v_scroll_bar()
		if max_scroll_length != scrollbar.max_value: #check if scroll diff
			max_scroll_length = scrollbar.max_value
			UIScrollMessages.scroll_vertical = scrollbar.max_value
	#pass
