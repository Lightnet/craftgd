extends Control

var grabbed_slot_data: SlotData

@onready var player_inventory = $PlayerInventory
@onready var grabbed_slot = $GrabbedSlot

func _physics_process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
		pass

func set_player_inventory_data(inventory_data:InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)
	pass

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int)->void:
	#print("%s %s %s" % [inventory_data, index, button])
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
			
	#print(grabbed_slot_data)
	update_grabbed_slot()
	pass

func update_grabbed_slot()->void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
	pass
