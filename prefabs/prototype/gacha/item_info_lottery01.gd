extends VBoxContainer

@onready var texture_rect = $TextureRect
@onready var label = $Label

func set_item_data(_slot_item:SlotData):
	#print("ADD????", _slot_item)
	#print("Name: ", _slot_item.item_data.name)
	texture_rect.texture = _slot_item.item_data.texture
	label.text = _slot_item.item_data.name
	#pass
