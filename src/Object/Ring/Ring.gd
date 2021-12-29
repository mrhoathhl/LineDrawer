extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween_scale = get_node("Tween")
onready var tween_opacity = get_node("Tween")
onready var sprite = get_node("Sprite")
var tween_step = [Vector2(1.3, 1.3), Vector2(1.7, 1.7)]
# Called when the node enters the scene tree for the first time.
func _ready():
	get_scale()
	sprite.scale = Vector2(0.3, 0.3)
	start_tween(tween_step[0], tween_step[1])
	print(sprite.scale)


func start_tween(vec1, vec2):
	tween_scale.interpolate_property(sprite, 'scale', vec1, vec2, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween_scale.start()
	yield(tween_scale, "tween_completed")
	tween_scale.interpolate_property(sprite, "modulate", 
	  Color(1, 1, 1, 1), Color(1, 1, 1, 0), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.5)
	tween_scale.start()

func get_scale():
	if GameInstance.diffcult == "Easy":
		sprite.scale = Vector2(0.7, 0.7)
		tween_step =  [Vector2(0.7, 0.7), Vector2(1, 1)]
	elif GameInstance.diffcult == "Medium":
		sprite.scale = Vector2(0.6, 0.6)
		tween_step =  [Vector2(0.6, 0.6), Vector2(0.9, 0.9)]
	elif GameInstance.diffcult == "Hard":
		sprite.scale = Vector2(0.5, 0.5)
		tween_step =  [Vector2(0.5, 0.5), Vector2(0.8, 0.8)]
	elif GameInstance.diffcult == "Expert":
		sprite.scale = Vector2(0.4, 0.4)
		tween_step =  [Vector2(0.4, 0.4), Vector2(0.7, 0.7)]
	else:
		sprite.scale = Vector2(0.3, 0.3)
		return [Vector2(0.3, 0.3), Vector2(0.6, 0.6)]

