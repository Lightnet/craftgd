extends Node

var socket = WebSocketPeer.new()

func _ready():
	#socket.connect_to_url("ws://localhost:3000")
	pass
	
func _process(_delta):
	#loop_websocket()
	pass
	
func loop_websocket():
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			#print("Packet: ", socket.get_packet())
			var msg =  get_message()
			if msg:
				print("msg: ", msg)
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.
	pass

func get_message() -> Variant:
	if socket.get_available_packet_count() < 1:
		return null
	var pkt = socket.get_packet()
	if socket.was_string_packet():
		return pkt.get_string_from_utf8()
	return bytes_to_var(pkt)

func getMessage():
	
	pass



func _request_test01():
	#_request_get_01()
	_request_post_01()
	pass

func _request_get_01():
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request("http://localhost:3000/api/json")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	pass

func _request_post_01():
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	# Perform a POST request. The URL below returns JSON as of writing.
	# Note: Don't make simultaneous requests using a single HTTPRequest node.
	# The snippet below is provided for reference only.
	var body = JSON.stringify({"name": "Godette"})
	print("body: ", body)
	var headers = PackedStringArray(["Content-Type: application/json"])

	var error = http_request.request("http://localhost:3000/api/json", headers, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	pass

# Called when the HTTP request is completed.
func _http_request_completed(result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	#print(response.headers["User-Agent"])
	print("result: ", result)
	print("response: ", response)

func _request_test00():
	var err = 0
	var http = HTTPClient.new() # Create the Client.
	print("init request...")

	err = http.connect_to_host("localhost", 3000) # Connect to host/port.
	assert(err == OK) # Make sure connection is OK.
	
	# Wait until resolved and connected.
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		print("Connecting...")
		#if not OS.has_feature("web"):
			#OS.delay_msec(500)
		#else:
			#yield(Engine.get_main_loop(), "idle_frame")
			#await Engine.get_main_loop().idle_frame
		await Engine.get_main_loop().idle_frame

	assert(http.get_status() == HTTPClient.STATUS_CONNECTED) # Check if the connection was made successfully.
	
	print("http.get_status(): ",http.get_status())
	
func getToken(_user="",_password=""):
	pass
	
func requestMainServer():
	pass
