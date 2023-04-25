extends HBoxContainer

@onready var research_list = $Panel/VBoxContainer/ScrollContainer/ResearchList
var research_slot = preload("res://research/research_data_slot.tscn")
var player_ResearchData:PlayerResearch

func _ready():
	check_research_data()
	pass

func check_research_data():
	#if GameData.check_player_data_exist():
	GameData.update_player_research_data.connect(setup_research_data)
	#pass
	
func _exit_tree():
	GameData.update_player_research_data.disconnect(setup_research_data)
	#pass
	
func clear_list():
	# Remove any previous list
	for child in research_list.get_children():
		research_list.remove_child(child)
		child.queue_free()
		
func setup_research_data(_player_researchdata):
	#var _researchdata = GameData.load_player_research_data()
	var _researchdata = _player_researchdata
	if _researchdata:
		player_ResearchData = _researchdata
		clear_list()
		
		for data in player_ResearchData.researchs:
			var slot_data  = research_slot.instantiate()
			#print("data: ",data)
			#print("Name: ",data.name)
			research_list.add_child(slot_data)
			slot_data.set_data(data)
			#slot_data.set_data()
	pass
