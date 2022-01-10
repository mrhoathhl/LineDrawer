extends Control


var level
var level_back_up = load("res://src/Map/Level/"+ GameInstance.diffcult + "/" + GameInstance.diffcult + "1.tscn")
var type
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
	$LevelContainer.add_child(level)
	
	$HBoxContainer/Background.texture = GameInstance.theme
	$ThemePopup.connect("on_change_theme", self, "_on_background_change")
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
	SoundController.touch_sound()
	emit_signal("on_hint_click")
	_on_GamePlayScene_on_hint_click()
	if AdManager.is_reward_ready:
		type = "hint"
		AdManager.show_reward(AdManager.reward_id)
	pass
	

func _on_Skip_pressed():
	SoundController.touch_sound()
	if AdManager.is_reward_ready:
		type = "skip"
		AdManager.show_reward(AdManager.reward_id)
	pass

func _on_Theme_pressed():
	if !GameInstance.is_popup :
		SoundController.touch_sound()
		GameInstance.is_play = false;
		GameInstance.is_popup = true;
		$ThemePopup.visible = true

func _on_Setting_pressed():
	if !GameInstance.is_popup :
		SoundController.touch_sound()
		GameInstance.is_play = false;
		GameInstance.is_popup = true;
		$SettingPopup.set_visible(true)

func _on_inter_close():
	if type == "next":
		$WinPopup.visible = false
		get_tree().reload_current_scene()
	else:
		SceneManager.transition(SceneManager.main_menu_scene)
	
func _on_reward_close():
	pass
	
func _on_background_change(type):
	GameInstance.theme = load("res://src/Assets/Textures/Background/" + type + ".png")
	$HBoxContainer/Background.texture = GameInstance.theme
	pass

func _on_reward_rewarded():
	print("reward close")
	if type == "hint":
		emit_signal("on_hint_click")
		_on_GamePlayScene_on_hint_click()
	elif type == "skip":
		get_tree().reload_current_scene()
