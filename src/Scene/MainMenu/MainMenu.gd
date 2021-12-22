extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var admob = Admobs

# Called when the node enters the scene tree for the first time.
func _ready():
	#admob.show_banner()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Medium_pressed():
	#GameInstance.diffcult = "Medium"
	SceneManager.transition(SceneManager.game_play_scene)
	print("Medium")


func _on_Hard_pressed():
	#GameInstance.diffcult = "Hard"
	SceneManager.transition(SceneManager.game_play_scene)
	print("Hard")


func _on_Expert_pressed():
	#GameInstance.diffcult = "Expert"
	SceneManager.transition(SceneManager.game_play_scene)
	print("Expert")


func _on_Professor_pressed():
	#GameInstance.diffcult = "Professor"
	SceneManager.transition(SceneManager.game_play_scene)
	print("Professor")


func _on_Easy_pressed():
	#GameInstance.diffcult = "Easy"
	#SceneManager.transition(SceneManager.game_play_scene)
	print("Easy")



func _on_Button_pressed():
	$Label.text =" clcicc"
