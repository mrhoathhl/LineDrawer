extends Node
var level = 1
var game_file = "user://gamedata.dat"

func _init():
	load_level()
	#save_level(1)

func load_level():
	var file = File.new()
	if file.file_exists(game_file):
		file.open(game_file, File.READ)
		level = file.get_var()
		file.close()

func save_level(level):
	var file = File.new()
	file.open(game_file, File.WRITE)
	file.store_var(33)
	file.close()
