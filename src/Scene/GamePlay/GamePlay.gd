extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#const preload_level = preload("res://src/Map/Level/level1.tscn")

var level
var level_back_up = load("res://src/Map/Level/" + GameInstance.diffcult + "/level1.tscn")
var container
var rng = RandomNumberGenerator.new()
func _init():
	
	
	level = load("res://src/Map/Level/level" + str(GameInstance.current_level) + ".tscn")
	if level != null:
		level.instance()
	else:
		level = level_back_up.instance()
	print(GameInstance.diffcult)
	print("Constructed!")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	container = get_node("Control")
	container.add_child(level)
	
func get_level() -> int:
	rng.randomize()
	var my_random_number = rng.randi_range(-10.0, 10.0)
	if my_random_number != GameInstance.last_level:
		return my_random_number
	else:
		get_level()
	return 1
	
