extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = get_node("Tween")
onready var sprite = get_node("Sprite")
var tween_step = [Vector2(0.8, 0.8), Vector2(1, 1)]
# Called when the node enters the scene tree for the first time.
func _ready():
	start_tween(tween_step[0], tween_step[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_tween(vec1, vec2):
	tween.interpolate_property(sprite, 'scale', vec1, vec2, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_completed(object, key):
	tween_step.invert()
	start_tween(tween_step[0], tween_step[1])
