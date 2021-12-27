extends Control


var level
var level_back_up = load("res://src/Map/Level/"+ GameInstance.diffcult + "/" + GameInstance.diffcult + "1.tscn")
var container
onready var sound_on = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOn
onready var sound_off = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOff
func _init():
	GameInstance.is_play = true;
	var next_level = load("res://src/Map/Level/" + GameInstance.diffcult + "/" + GameInstance.diffcult + str(get_level()) + ".tscn")
	if next_level != null:
		level = next_level.instance()
	else:
		level = level_back_up.instance()
	
	
func _ready():
	applovin_max.showBanner("1e5566a719a445cf")
	print("banner")
	applovin_max.showInterstitial("f20db4009e262ded")
	print("inter")
	$LevelNumber.text = "Level " + str(GameInstance.display_level)
	$LevelContainer.add_child(level)
	if Global.is_sound_on:
		sound_on.visible = true
		sound_off.visible = false
	else:
		sound_on.visible = false
		sound_off.visible = true
		
	
func get_level() -> int:
	if !GameInstance.is_reload:
		GameInstance.is_reload = false
		var next_level = GameInstance.current_level + 1
		print(next_level)
		if next_level >= GameInstance.total_level:
			GameInstance.current_level = 1
			return  1
		else:
			GameInstance.current_level = next_level
			return next_level
	else:
		print("net")
		return GameInstance.current_level
	return 1
	


func _on_Next_pressed():
	GameInstance.is_reload = false
	GameInstance.is_play = true
	GameInstance.display_level += 1
	SoundController.touch_sound()
	get_tree().reload_current_scene()
	$WinPopup.visible = false

func _on_Setting_pressed():
	SoundController.touch_sound()
	GameInstance.is_play = false;
	$SettingPopup.visible = true


func _on_ClosePopup_pressed():
	SoundController.touch_sound()
	GameInstance.is_play = true;
	$SettingPopup.visible = false


func _on_Sound_pressed():
	SoundController.touch_sound()
	Global.is_sound_on = !Global.is_sound_on
	if sound_on.visible:
		sound_on.visible = false
		sound_off.visible = true
	else:
		sound_on.visible = true
		sound_off.visible = false
		

func _on_Replay_pressed():
	SoundController.touch_sound()
	GameInstance.is_reload = true
	GameInstance.is_play = true
	get_tree().reload_current_scene()


func _on_Back_pressed():
	SceneManager.transition(SceneManager.main_menu_scene)
