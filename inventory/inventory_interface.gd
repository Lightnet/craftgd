extends Control

signal drop_slot_data(slot_data:SlotData)
signal force_close
var grabbed_slot_data: SlotData
var external_inventory_owner

@onready var player_inventory = $PlayerInventory
@onready var grabbed_slot = $GrabbedSlot
@onready var external_inventory = $ExternalInventory
@onready var equp_inventory = $EqupInventory

func _physics_process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
		pass
	if external_inventory_owner \
			and external_inventory_owner.global_position.distance_to(PlayerManager.get_global_position()) > 4:
		force_close.emit()
func set_player_inventory_data(inventory_data:InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)
	pass

func set_equip_inventory_data(inventory_data:InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	equp_inventory.set_inventory_data(inventory_data)
	#pass

func set_external_inventory(_external_inventory_owner):
	#print(_external_inventory_owner)
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	
	inventory_data.inventory_interact.connect(on_inventory_interact)
	external_inventory.set_inventory_data(inventory_data)
	external_inventory.show()
	pass

func clear_external_inventory():
	#print(_external_inventory_owner)
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		external_inventory.clear_inventory_data(inventory_data)
		
		external_inventory.hide()
		external_inventory_owner = null
	pass

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int)->void:
	#print("%s %s %s" % [inventory_data, index, button])
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.use_slot_data(index)
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)	
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


func _on_gui_input(event: InputEvent)->void:
	if event is InputEventMouse \
			and event.is_pressed() \
			and grabbed_slot_data:
	
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				drop_slot_data.emit(grabbed_slot_data)
				grabbed_slot_data = null
				#print("DROP DATA")
			MOUSE_BUTTON_RIGHT:
				drop_slot_data.emit(grabbed_slot_data.create_single_slot_data())
				if grabbed_slot_data.quantity < 1:
					grabbed_slot_data = null
					
		update_grabbed_slot()
	#pass
func _on_visibility_changed():
	if not visible and grabbed_slot_data:
		drop_slot_data.emit(grabbed_slot_data)
		grabbed_slot_data = null
		update_grabbed_slot()

