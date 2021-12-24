extends Control


var level
var level_back_up = preload("res://src/Map/Level/Easy/Easy1.tscn")
var container
var rng = RandomNumberGenerator.new()
onready var sound_on = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOn
onready var sound_off = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOff
func _init():
	GameInstance.is_play = true;
	var next_level = load("res://src/Map/Level/" + GameInstance.diffcult + "/" + GameInstance.diffcult + str(get_level()) + ".tscn")
	print(next_level)
	if next_level != null:
		level = next_level.instance()
	else:
		level = level_back_up.instance()
	
	
func _ready():
	$LevelNumber.text = "Level " + str(GameInstance.display_level)
	$LevelContainer.add_child(level)
	
func get_level() -> int:
	rng.randomize()
	var my_random_number = rng.randi_range(1, GameInstance.total_level)
	if !GameInstance.is_reload:
		GameInstance.is_reload = false
		if my_random_number != GameInstance.last_level:
			GameInstance.current_level = my_random_number
			return my_random_number
		else:
			var level = GameInstance.current_level + 1
			if level > GameInstance.total_level:
				return 1
			else:
				return level
	else:
		print("net")
		return GameInstance.current_level
	return 1
	


func _on_Next_pressed():
	GameInstance.is_reload = false
	GameInstance.is_play = true
	GameInstance.display_level += 1
	get_tree().reload_current_scene()
	$WinPopup.visible = false

func _on_Setting_pressed():
	GameInstance.is_play = false;
	$SettingPopup.visible = true


func _on_ClosePopup_pressed():
	GameInstance.is_play = true;
	$SettingPopup.visible = false


func _on_Sound_pressed():
	if sound_on.visible:
		sound_on.visible = false
		sound_off.visible = true
	else:
		sound_on.visible = true
		sound_off.visible = false
		


func _on_Replay_pressed():
	GameInstance.is_reload = true
	GameInstance.is_play = true
	get_tree().reload_current_scene()


func _on_Back_pressed():
	SceneManager.transition(SceneManager.main_menu_scene)
