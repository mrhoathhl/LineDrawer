extends Node2D
var current_level = 1
var total_level = 20
var display_level = 1
var game_file = "user://gamedata.dat"
var diffcult = "Easy"
var ad_time_last_show = 0
var time_interval = 20000
var check_connection

var rng = RandomNumberGenerator.new()
var is_reload = false
var is_play = true
var is_sound_on = true

onready var vp = get_tree().get_root()
onready var base_size = Vector2(1080, 1920)

func _ready():
	if Engine.has_singleton("CheckConnection"):
		check_connection = Engine.get_singleton("CheckConnection")
	print(check_connection.isConnected())
	pass

func _init():
	rng.randomize()
	var my_random_number = rng.randi_range(1, total_level)
	current_level = my_random_number
	load_current_level()
	
func load_current_level():
	var file = File.new()
	if file.file_exists(game_file):
		file.open(game_file, File.READ)
		display_level = file.get_var()
		file.close()

func save_current_level(current_levels):
	var file = File.new()
	file.open(game_file, File.WRITE)
	file.store_var(current_levels)
	file.close()
