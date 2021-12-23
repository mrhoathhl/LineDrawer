extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var color_set = -1 # -1 == random
onready var tween_node = get_node("Tween")
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = get_node("Button")
	button.connect("pressed", self, "_button_pressed")
	tween_node.interpolate_property(self, 'opacity', 0, .5, 1.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	add_child(tween_node)
	tween_node.start()

func _button_pressed():
	print()


func _on_Tween_tween_completed(object, key):
	print("complete")
