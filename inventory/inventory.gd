extends PanelContainer

const Slot = preload("res://inventory/slot.tscn")

@onready var item_grid = $MarginContainer/ItemGrid

func _ready():
	#test
	#var inv_data = preload("res://tests/test_inventory.tres")
	#populate_item_grid(inv_data.slot_datas)
	pass

func set_inventory_data(inventory_data:InventoryData)->void:
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)
	#pass

func clear_inventory_data(inventory_data:InventoryData)->void:
	inventory_data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(inventory_data:InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_click.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)
			pass
	pass
