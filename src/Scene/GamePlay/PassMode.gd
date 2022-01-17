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

func _on_Next_pressed():
	SoundController.touch_sound()
	GameInstance.is_reload = false
	GameInstance.is_play = true
	GameInstance.display_level += 1
	get_parent().save_current_level()
	if AdManager.is_inter_ready:
		if GameInstance.display_level == 50:
			GameInstance.type = "pass"
		else:
			GameInstance.type = "next"
		AdManager.show_inter(AdManager.inter_id)
	else:
		visible = false
		get_tree().reload_current_scene()
	pass # Replace with function body.
