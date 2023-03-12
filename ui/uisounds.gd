extends Node
# https://www.youtube.com/watch?v=QgBecUl_lFs
# https://codeberg.org/Liblast/Liblast/src/commit/830727eb35ceb3d88fa72abd03b9db282d9a5ad9/Game/Assets/UI/UiSounds.gd
@export var root_path: NodePath

@onready var sounds = {
	&"UI_Hover":AudioStreamPlayer.new(),
	&"UI_Click":AudioStreamPlayer.new(),
	#&"UI_Cancel":AudioStreamPlayer.new(),
	#&"UI_Message":AudioStreamPlayer.new(),
	#&"UI_Accept":AudioStreamPlayer.new(),
}

func _ready():
	assert(root_path != null, "Empty root path for UI sounds!")
	
	#set up audio stream players and load sound files
	for i in sounds.keys():
		sounds[i].stream = load("res://audio/soundeffect/"+ str(i) + ".mp3")
		sounds[i].bus = &"UI"
		add_child(sounds[i])
	
	#connect signals to the method that plays the sounds
	install_sounds(get_node(root_path))
	pass # Replace with function body.

func install_sounds(node:Node):
	for i in node.get_children():
		if i is Button:
			i.mouse_entered.connect(func(): ui_sfx_play(&"UI_Hover") )
			i.pressed.connect(func(): ui_sfx_play(&"UI_Click") )
		elif i is LineEdit:
			i.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover") )
			#i.text_submitted.connect( ui_sfx_play.bind(&"UI_Accept").unbind(1) )
			#i.text_change_rejected.connect( ui_sfx_play.bind(&"UI_Cancel").unbind(1) )
			#i.text_changed.connect( ui_sfx_play.bind(&"UI_Message").unbind(1) )
		#recursion
		install_sounds(i)
			
func ui_sfx_play(sound : String) -> void:
#	printt("Playing sound:", sound)
	sounds[sound].play()
