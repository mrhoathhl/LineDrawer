extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_Timer_timeout():
	$ProgressBar.value += 1
	if $ProgressBar.value == 100:
		yield(get_tree().create_timer(0.5), "timeout")
		SceneManager.transition(SceneManager.home_scene)
