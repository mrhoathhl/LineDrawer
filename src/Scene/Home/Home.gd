extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Help_pressed():
	SceneManager.transition(SceneManager.main_menu_scene)


func _on_Play_pressed():
	SceneManager.transition(SceneManager.main_menu_scene)


func _on_Button_pressed():
	$Label.text = "cl;cickc"
