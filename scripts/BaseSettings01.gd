extends Control


@onready var CurrentMenu = $"."
@onready var offline = $"../Offline"

func _on_button_pressed():
	CurrentMenu.hide()
	offline.show()
	pass
