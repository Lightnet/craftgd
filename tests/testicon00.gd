# https://godotengine.org/qa/25711/creating-an-icon-for-custom-class-in-editor-create-node-menu
# https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/gdscript_basics.html#registering-named-classes

@icon("res://icon/icon00.svg")
extends Node
class_name TestIcon00

@export var description = "test icon"
