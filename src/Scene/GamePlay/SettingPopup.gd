extends Control


onready var sound_on = get_node("/root/GamePlayScene/SettingPopup/Panel/Control/GridContainer/Sound/SoundOn")
onready var sound_off = get_node("/root/GamePlayScene/SettingPopup/Panel/Control/GridContainer/Sound/SoundOff")

func _ready():
	if GameInstance.is_sound_on:
		sound_on.visible = true
		sound_off.visible = false
	else:
		sound_on.visible = false
		sound_off.visible = true
	pass # Replace with function body.
	
func _on_Sound_pressed():
	SoundController.touch_sound()
	GameInstance.is_sound_on = !GameInstance.is_sound_on
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
	GameInstance.is_popup = false
	get_tree().reload_current_scene()

func _on_Back_pressed():
	SoundController.touch_sound()
	GameInstance.is_popup = false
	GameInstance.type = "back"
	if AdManager.is_inter_ready:
		AdManager.show_inter(AdManager.inter_id)
	else:
		SceneManager.transition(SceneManager.main_menu_scene)
	
func _on_CloseSettingPopup_pressed():
	SoundController.touch_sound()
	GameInstance.is_play = true;
	GameInstance.is_popup = false
	visible = false
