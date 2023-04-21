extends Control

@onready var reward_result = $RewardResult
@onready var menu_reward = $MenuReward

@export var inventory_data: InventoryData

func _ready():
	menu_reward.show()
	reward_result.hide()

func _on_btn_sigin_in_pressed():
	
	menu_reward.hide()
	reward_result.show()
	pass

func _on_btn_draw_daily_pressed():
	menu_reward.hide()
	reward_result.show()
	pass

func _on_btn_claim_pressed():
	
	
	menu_reward.show()
	reward_result.hide()
	pass
