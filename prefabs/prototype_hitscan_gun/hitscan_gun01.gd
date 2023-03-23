extends Node3D
# https://www.youtube.com/watch?v=n8D3vEx7NAE&t=1s

#@onready var muzzle_flash = $Holder/MeshInstance3D/MuzzleFlash
@onready var anim_player = $AnimationPlayer
#var anim_player = null
#@onready var body = $"../../.."

#func _enter_tree():
	#anim_player = get_node("AnimationPlayer")
	#pass
# Called when the node enters the scene tree for the first time.
func _ready():
	#anim_player = get_node("AnimationPlayer")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(_event):
	#if not is_multiplayer_authority(): return
	if anim_player == null:
		#anim_player = $AnimationPlayer
		return
	if Input.is_action_just_pressed("shoot") and anim_player.current_animation != "shoot":
		#print("SHOOT AMIN")
		#play_shoot_effects()
		play_shoot_effects.rpc()
		#if raycast.is_colliding():
			#var hit_player = raycast.get_collider()
			#hit_player.receive_damage.rpc_id(hit_player.get_multiplayer_authority())

func _physics_process(_delta):
	if not is_multiplayer_authority(): return
	#print("Hello test?")
	#if anim_player == null || body == null:
	if anim_player == null:
		#anim_player = $AnimationPlayer
		return
	#print("anim_player.current_animation:", anim_player.current_animation)
	#print("body.get(`isMove`):", body.get("isMove"))
	#print("body.get(`isMove`):", body.get("script").get("isMove"))
	#print("body.get(`isMove`):", body.isMove)
	if anim_player.current_animation == "shoot":
		pass
	#elif (body.get("isMove") == true) and (body.is_on_floor() == true):
		#print("MOVE>??")
		#anim_player.play("move")
	#else:
		#anim_player.play("idle")


@rpc("call_local")
func play_shoot_effects():
	#print("shoot")
	anim_player.stop()
	anim_player.play("shoot")
	#muzzle_flash.restart()
	#muzzle_flash.emitting = true
	pass
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shoot":
		anim_player.play("idle")
	pass
