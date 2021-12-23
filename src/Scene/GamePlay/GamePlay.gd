extends Control


var level
var level_back_up = preload("res://src/Map/Level/Easy/Easy1.tscn")
var container
var rng = RandomNumberGenerator.new()
func _init():
	level = level_back_up.instance()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$LevelContainer.add_child(level)
	
func get_level() -> int:
	rng.randomize()
	var my_random_number = rng.randi_range(-10.0, 10.0)
	if my_random_number != GameInstance.last_level:
		GameInstance.last_level = my_random_number
		return my_random_number
	else:
		get_level()
	return 1
	
