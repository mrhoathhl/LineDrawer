extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var color_set = -1 # -1 == random
onready var tween_node = get_node("Tween")
onready var particles_right = $CPUParticles2DLeft
onready var particles_left = $CPUParticles2DRight
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = get_node("Button")
	button.connect("pressed", self, "_button_pressed")
	tween_node.interpolate_property(self, 'opacity', 0, .5, 1.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	add_child(tween_node)
	tween_node.start()

func start_particles():
	particles_right.one_shot = true
	particles_left.one_shot = true
	var color_number = color_set if (color_set >= 0 && color_set < 6) else randi() % 6
	particles_right.color_ramp = load(str("res://colors/" + str(color_number) + ".tres"))
	particles_left.color_ramp = load(str("res://colors/" + str(color_number) + ".tres"))

func _button_pressed():
	print()

func _process(delta):
	if not particles_right.is_emitting():
		queue_free()
	if not particles_left.is_emitting():
		queue_free()

func _on_Tween_tween_completed(object, key):
	print("complete")
