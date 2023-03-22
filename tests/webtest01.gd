extends Node

@export var websocket_url = "ws://localhost:3000"

# Our WebSocketClient instance
var socket = WebSocketPeer.new()
#var _client = WebSocketClient.new()

#var _client = WebSocketClient.new()#nope remove #out date docs

func _ready():
	socket.connect_to_url(websocket_url)

func _process(delta):
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			print("Packet: ", socket.get_packet())
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.
	pass
