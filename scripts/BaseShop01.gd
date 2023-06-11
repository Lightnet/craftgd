extends Control


@onready var CurrentMenu = $"."
@onready var offline = $"../Offline"

func _on_button_pressed():
	offline.show()
	CurrentMenu.hide()
	pass
