extends Control

func _ready():
	$HBoxContainer/Background.texture = GameInstance.theme
	AdManager.connect("on_interstitial_close", self, "_on_inter_close")
	pass


func _on_Ease_pressed():
	GameInstance.display_level = GameInstance.list_level.Easy
	change_scene("Easy")

func _on_Medium_pressed():
	GameInstance.display_level = GameInstance.list_level.Medium
	change_scene("Medium")

func _on_Hard_pressed():
	GameInstance.display_level = GameInstance.list_level.Hard
	change_scene("Hard")

func _on_Expert_pressed():
	GameInstance.display_level = GameInstance.list_level.Expert
	change_scene("Expert")

func _on_Professor_pressed():
	GameInstance.display_level = GameInstance.list_level.Pro
	change_scene("Pro")
	
func change_scene(diff):
	GameInstance.diffcult = diff
	if AdManager.is_inter_ready:
		AdManager.show_inter(AdManager.inter_id)
	else:
		SceneManager.transition(SceneManager.game_play_scene)

func _on_inter_close():
	SceneManager.transition(SceneManager.game_play_scene)
