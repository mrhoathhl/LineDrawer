extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var admob = Admobs

# Called when the node enters the scene tree for the first time.
func _ready():
	AdManager.connect("on_interstitial_close", self, "_on_inter_close")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Ease_pressed():
	change_scene("Easy")

func _on_Medium_pressed():
	change_scene("Medium")

func _on_Hard_pressed():
	change_scene("Hard")

func _on_Expert_pressed():
	change_scene("Expert")

func _on_Professor_pressed():
	change_scene("Professor")
	
func change_scene(diff):
	GameInstance.diffcult = diff
	if AdManager.is_inter_ready:
		AdManager.show_inter(AdManager.inter_id)
	else:
		SceneManager.transition(SceneManager.game_play_scene)

func _on_inter_close():
	SceneManager.transition(SceneManager.game_play_scene)
