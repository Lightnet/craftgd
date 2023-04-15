extends Control

@onready var layer_animation = $LayerAnimation
@onready var result_item = $ResultItem
@onready var animation_player = $AnimationPlayer

@export var time_draw = 2

@export var char_inventory_data: InventoryData

@export var inventory_data: InventoryData

@onready var slot_ph = preload("res://prefabs/prototype/gacha/char_chest_icon.tscn")
@onready var item_loot = $ResultItem/CenterContainer/VBoxContainer/ScrollContainer/CenterContainer/ItemLoot

var rng = RandomNumberGenerator.new()

func _ready():
	randomize()	
	layer_animation.visible = false
	result_item.visible = false
	
	layer_animation.set_process(false)
	result_item.set_process(false)

func cleanslot():
	for nui in item_loot.get_children():
		item_loot.remove_child(nui)
		nui.queue_free()
		
func char_random():
	cleanslot()
	var total_count = char_inventory_data.slot_datas.size()
	if total_count > 0:
		total_count = total_count - 1
	print(" total_count: ", total_count)
	var random_number = rng.randi_range(0, total_count)
	print("random_number: ", random_number)
	
	var item_data = char_inventory_data.slot_datas[random_number]
	var slot_item = slot_ph.instantiate()
	item_loot.add_child(slot_item)
	slot_item.set_item_data(item_data)
	#slot_item.set_item_data()
	pass
	
func char_random10():
	
	var total_count = char_inventory_data.slot_datas.size() - 1
	print(" total_count: ", total_count)
	cleanslot()
	
	for n in 10:
		var random_number = rng.randi_range(0, total_count)
		print("random_number: ", random_number)
		var item_data = char_inventory_data.slot_datas[random_number]
		var itemui = slot_ph.instantiate()
		item_loot.add_child(itemui)
		itemui.set_item_data(item_data)
	pass

func item_random1():
	
	var total_count = inventory_data.slot_datas.size() - 1
	print(" total_count: ", total_count)
	cleanslot()
	
	var random_number = rng.randi_range(0, total_count)
	print("random_number: ", random_number)
	
	var item_data = inventory_data.slot_datas[random_number]
	var slot_item = slot_ph.instantiate()
	item_loot.add_child(slot_item)
	slot_item.set_item_data(item_data)
	pass

func item_random10():
	
	var total_count = inventory_data.slot_datas.size() - 1
	print(" total_count: ", total_count)
	cleanslot()
	
	for n in 10:
		var random_number = rng.randi_range(0, total_count)
		print("random_number: ", random_number)
		var item_data = inventory_data.slot_datas[random_number]
		
		var slot_item = slot_ph.instantiate()
		item_loot.add_child(slot_item)
		slot_item.set_item_data(item_data)
		
	pass

func start_loot_lottery():
	layer_animation.visible = true
	result_item.visible = true	
	layer_animation.set_process(true)
	result_item.set_process(true)
	#@pass

func end_loot_lottery():
	layer_animation.visible = false
	layer_animation.set_process(false)
	#pass

func _on_btn_character_draw_pressed():
	
	start_loot_lottery()
	char_random()
	await get_tree().create_timer(time_draw).timeout
	end_loot_lottery()
	#pass

func _on_btn_item_draw_pressed():
	
	start_loot_lottery()
	item_random1()
	await get_tree().create_timer(time_draw).timeout
	end_loot_lottery()
	#pass

func _on_btn_claim_pressed():
	
	layer_animation.visible = false
	result_item.visible = false
	layer_animation.set_process(false)
	result_item.set_process(false)
	#pass

func _on_btn_character_draw_10_pressed():
	
	start_loot_lottery()
	char_random10()
	await get_tree().create_timer(time_draw).timeout
	end_loot_lottery()
	#pass
	
func _on_btn_item_draw_10_pressed():
	
	start_loot_lottery()
	item_random10();
	await get_tree().create_timer(time_draw).timeout
	end_loot_lottery()
	#pass
