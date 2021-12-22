extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#const preload_level = preload("res://src/Map/Level/level1.tscn")
var level
#var level_back_up = preload("res://src/Map/Level/Easy/Easy1.tscn")
var container
var rng = RandomNumberGenerator.new()
func _init():
	level = load("res://src/Map/Level/Easy/Easy1.tscn").instance()
	#var load_level = load("res://src/Map/Level/" + GameInstance.diffcult + "/" + GameInstance.diffcult +  str(get_level()) + ".tscn")
	#print(level)
	#if load_level != null:
	#	level = load_level.instance()
	#else:
	#	level = level_back_up
	
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
		GameInstance.last_level = my_random_number
		return my_random_number
	else:
		get_level()
	return 1
	
