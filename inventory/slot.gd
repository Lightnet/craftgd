extends PanelContainer

signal slot_click(index: int, button: int)

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel

func set_slot_data(slot_data: SlotData):
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()
	else:
		quantity_label.hide()
	#pass

func _on_gui_input(event):
	if event is InputEventMouseButton \
			and ( event.button_index == MOUSE_BUTTON_RIGHT \
			or event.button_index == MOUSE_BUTTON_LEFT) \
			and event.is_pressed():
		slot_click.emit(get_index(), event.button_index)
	pass
