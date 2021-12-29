extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = get_node("Tween")
onready var particel = get_node("CPUParticles2D")
var sprite
var tween_step = [Vector2(1, 1), Vector2(0, 0)]
# Called when the node enters the scene tree for the first time.
func _ready():
	get_fading_block()
	start_tween(tween_step[0], tween_step[1])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_tween(vec1, vec2):
	tween.interpolate_property(sprite, 'scale', vec1, vec2, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(particel, 'scale', vec1, vec2, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.1)
	tween.start()
	
func get_fading_block():
	if GameInstance.diffcult == "Easy":
		sprite = $"216"
		$"216".visible = true
		$"180".visible = false
		$"154".visible = false
		$"135".visible = false
		$"120".visible = false
	elif GameInstance.diffcult == "Medium":
		sprite = $"180"
		$"216".visible = false
		$"180".visible = true
		$"154".visible = false
		$"135".visible = false
		$"120".visible = false
	elif GameInstance.diffcult == "Hard":
		sprite = $"154"
		$"216".visible = false
		$"180".visible = false
		$"154".visible = true
		$"135".visible = false
		$"120".visible = false
	elif GameInstance.diffcult == "Expert":
		sprite = $"135"
		$"216".visible = false
		$"180".visible = false
		$"154".visible = false
		$"135".visible = true
		$"120".visible = false
	else:
		sprite = $"120"
		$"216".visible = false
		$"180".visible = false
		$"154".visible = false
		$"135".visible = false
		$"120".visible = true
	
