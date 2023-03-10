extends Node

var characters = 'abcdefghijklmnopqrstuvwxyz'
var numbers = '0123456789'

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func generate_word(chars, length):
	var word: String = ""
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word

func generate_random_name(_len):
	if _len == null:
		_len = 11
	return generate_word(characters, _len)

func generate_random_numbers():
	return generate_word(numbers, 32)
