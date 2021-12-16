extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#const preload_level = preload("res://src/Map/Level/level1.tscn")

var preload_level = preload("res://src/Map/Level/level1.tscn")
var preload_level_back_up = preload("res://src/Map/Level/level1.tscn")
var level
var container

func _init():
	preload_level = load("res://src/Map/Level/level" + str(GameInstance.level) + ".tscn")
	print("Constructed!")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	container = get_node("Control")
	if preload_level != null:
		level = preload_level.instance()
	else:
		level = preload_level_back_up.instance()
	container.add_child(level)
