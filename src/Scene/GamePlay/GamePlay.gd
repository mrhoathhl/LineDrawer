extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const preload_level = preload("res://src/Map/level1.tscn")
func _init():
	print("Constructed!")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button")
	var container = get_node("Control")
	var level = preload_level.instance()
	add_child(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_node("Label").text = "HELLO!"
