extends Node

func _unhandled_input(_event):
	if Input.is_action_pressed("ToggleInteractMenu"):
		print("menu")
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _ready():
	pass

func _process(_delta):	
	pass


func _on_btn_http_request_pressed():
	Networkweb._request_test01()
	pass # Replace with function body.
