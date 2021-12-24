extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(1.0), "timeout")
	#SceneManager.transition(SceneManager.home_scene)
	
func _on_Timer_timeout():
	print("clcick")
	$ProgressBar.value += 1
