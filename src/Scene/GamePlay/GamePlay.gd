extends Control


var level
var level_back_up = preload("res://src/Map/Level/Easy/Easy1.tscn")
var container
var rng = RandomNumberGenerator.new()
onready var sound_on = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOn
onready var sound_off = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOff
func _init():
	level = level_back_up.instance()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$LevelContainer.add_child(level)
	
func get_level() -> int:
	rng.randomize()
	var my_random_number = rng.randi_range(-10.0, 10.0)
	if my_random_number != GameInstance.last_level:
		GameInstance.last_level = my_random_number
		return my_random_number
	else:
		get_level()
	return 1
	


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
	pass


func _on_Back_pressed():
	SceneManager.transition(SceneManager.main_menu_scene)
