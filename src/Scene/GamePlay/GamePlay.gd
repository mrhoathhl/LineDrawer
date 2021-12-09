extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const preload_level = preload("res://src/Map/untitled.tmx")
func _init():
	print("Constructed!")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button")
	var container = get_node("Area2D/Container")
	var level = preload_level.instance()
	container.add_child(level)
	print("Constructsed!" , level.get_children())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_node("Label").text = "HELLO!"
