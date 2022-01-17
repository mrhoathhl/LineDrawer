extends CanvasLayer

var main_menu_scene = "res://src/Scene/MainMenu/MainMenu.tscn"
var game_play_scene = "res://src/Scene/GamePlay/GamePlay.tscn"
var select_level_scene = "res://src/Scene/LevelSelect/LevelSelectScene.tscn"

var current_scene = null
var next_scene

func _ready():
	pass
	
func transition(scene_path):
	SoundController.touch_sound()
	next_scene = scene_path
	get_tree().change_scene(next_scene)
