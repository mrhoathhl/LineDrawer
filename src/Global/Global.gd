extends Node
var current_level = 1
var last_level = 1;
var total_level = 60
var display_level = 1
var is_play = true
var game_file = "user://gamedata.dat"
var diffcult = "Easy"
var is_reload = false

func _init():
	#load_current_level()
	#save_current_level(1)
	pass

func load_current_level():
	var file = File.new()
	if file.file_exists(game_file):
		file.open(game_file, File.READ)
		current_level = file.get_var()
		file.close()

func save_current_level(current_level):
	var file = File.new()
	file.open(game_file, File.WRITE)
	file.store_var(33)
	file.close()
