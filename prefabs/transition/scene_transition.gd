extends CanvasLayer
# https://www.youtube.com/watch?v=yZQStB6nHuI
# https://docs.godotengine.org/en/stable/tutorials/scripting/scene_tree.html
# https://docs.godotengine.org/en/stable/classes/class_scenetree.html#class-scenetree-method-change-scene-to-file
# https://docs.godotengine.org/en/stable/classes/class_scenetree.html#class-scenetree-method-change-scene-to-packed
# SceneTreeTimer create_timer ( float time_sec, bool process_always=true, bool process_in_physics=false, bool ignore_time_scale=false )

var delay_time = 2

func change_scene(target:String) -> void:
	$AnimationPlayer.play("dissolve")
	#await $AnimationPlayer.animation_finished()
	#print("wait")
	await get_tree().create_timer(delay_time).timeout
	#print("next")
	#get_tree().change_scene(target)
	get_tree().change_scene_to_file(target)
	#await get_tree().create_timer(delay_time).timeout
	$AnimationPlayer.play_backwards("dissolve")
