extends CanvasLayer

var home_scene = "res://src/Scene/Home/Home.tscn"
var main_menu_scene = "res://src/Scene/MainMenu/MainMenu.tscn"
var game_play_scene = "res://src/Scene/GamePlay/GamePlay.tscn"

var current_scene = null
var next_scene
signal transitioned

func _ready():
	pass
	
func transition(scene_path):
	SoundController.touch_sound()
	next_scene = scene_path
	get_tree().change_scene(next_scene)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		print("black")
		get_tree().change_scene(next_scene)
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_out")
	elif anim_name == "fade_out":
		pass
