extends Control


var level
var level_back_up = load("res://src/Map/Level/"+ GameInstance.diffcult + "/" + GameInstance.diffcult + "1.tscn")
var type
onready var sound_on = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOn
onready var sound_off = $SettingPopup/Panel/Control/GridContainer/Sound/SoundOff
signal on_hint_click

func _init():
	GameInstance.is_play = true;
	var next_level = load("res://src/Map/Level/" + GameInstance.diffcult + "/" + GameInstance.diffcult + str(get_level()) + ".tscn")
	if next_level != null:
		level = next_level.instance()
	else:
		level = level_back_up.instance()
	
	
	
func _ready():
	$LevelNumber.text = "Level " + str(GameInstance.display_level)
	add_child(level)
	if Global.is_sound_on:
		sound_on.visible = true
		sound_off.visible = false
	else:
		sound_on.visible = false
		sound_off.visible = true
		
	AdManager.connect("on_interstitial_close", self, "_on_inter_close")
	AdManager.connect("on_reward_close", self, "_on_reward_close")
	AdManager.connect("on_reward_rewarded", self, "_on_reward_rewarded")
	
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
	
func _on_GamePlayScene_on_hint_click():
	pass

func _on_Hint_pressed():
	if AdManager.is_reward_ready:
		type = "hint"
		AdManager.show_reward(AdManager.reward_id)
	pass
	

func _on_Skip_pressed():
	if AdManager.is_reward_ready:
		type = "skip"
		AdManager.show_reward(AdManager.reward_id)
	pass


func _on_Next_pressed():
	GameInstance.is_reload = false
	GameInstance.is_play = true
	GameInstance.display_level += 1
	SoundController.touch_sound()
	type = "next"
	if AdManager.is_inter_ready:
		AdManager.show_inter(AdManager.inter_id)
	else:
		$WinPopup.visible = false
		get_tree().reload_current_scene()

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
	type = "back"
	if AdManager.is_inter_ready:
		AdManager.show_inter(AdManager.inter_id)
	else:
		SceneManager.transition(SceneManager.main_menu_scene)
	
func _on_inter_close():
	if type == "next":
		$WinPopup.visible = false
		get_tree().reload_current_scene()
	else:
		SceneManager.transition(SceneManager.main_menu_scene)
	
func _on_reward_close():
	pass

func _on_reward_rewarded():
	print("reward close")
	if type == "hint":
		emit_signal("on_hint_click")
		_on_GamePlayScene_on_hint_click()
	elif type == "skip":
		get_tree().reload_current_scene()
