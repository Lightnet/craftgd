extends Control

var map_path = "res://maps/tower_defense_02.tscn"

func _on_btn_start_pressed():
	
	get_tree().change_scene_to_file(map_path)
	
	pass 
