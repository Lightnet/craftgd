extends HBoxContainer

@onready var l_name = $L_Name
@onready var l_cost = $LCost
@onready var btn_is_unlocked = $HBoxContainer/btnIsUnlocked
@onready var btn_upgrade = $HBoxContainer/btnUpgrade

var researchData:ResearchData

func set_data(_researchdata:ResearchData):
	researchData = _researchdata
	l_name.text = _researchdata.name
	l_cost.text = str(_researchdata.cost)
	
	if _researchdata.isUnlocked:
		btn_is_unlocked.hide()
		btn_upgrade.show()
	else:
		btn_is_unlocked.show()
		btn_upgrade.hide()
	pass

func _on_btn_upgrade_pressed():
	researchData.level += 1
	GameData.update_player_research_data_slot(researchData)
	pass

func _on_btn_is_unlocked_pressed():
	researchData.isUnlocked = 1
	GameData.update_player_research_data_slot(researchData)
	btn_is_unlocked.hide()
	btn_upgrade.show()
	pass
