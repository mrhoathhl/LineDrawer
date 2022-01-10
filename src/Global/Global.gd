extends Node2D
var current_level = 1
var total_level = 20
var display_level = 1
var game_file = "user://gamedata.json"
var bg_file = "user://userdata.json"
var diffcult = "Easy"
var ad_time_last_show = 0
var time_interval = 20000
var check_connection

var rng = RandomNumberGenerator.new()
var is_reload = false
var is_play = true
var is_popup = false
var is_sound_on = true
var list_background : Dictionary

const itemBackground = {
	0: {
		"itemName": "bg1",
		"itemIcon": "res://src/Assets/Textures/Background/icon1.png",
		"status": true
	},
	1: {
		"itemName": "bg2",
		"itemIcon": "res://src/Assets/Textures/Background/icon2.png",
		"status": false
	},
	2: {
		"itemName": "bg3",
		"itemIcon": "res://src/Assets/Textures/Background/icon3.png",
		"status": false
	},
	3: {
		"itemName": "bg4",
		"itemIcon": "res://src/Assets/Textures/Background/icon4.png",
		"status": false
	},
	4: {
		"itemName": "bg5",
		"itemIcon": "res://src/Assets/Textures/Background/icon5.png",
		"status": false
	},
	5: {
		"itemName": "bg6",
		"itemIcon": "res://src/Assets/Textures/Background/icon6.png",
		"status": false
	},
	6: {
		"itemName": "bg7",
		"itemIcon": "res://src/Assets/Textures/Background/icon7.png",
		"status": false
	},
	7: {
		"itemName": "bg8",
		"itemIcon": "res://src/Assets/Textures/Background/icon8.png",
		"status": false
	},
	8: {
		"itemName": "bg9",
		"itemIcon": "res://src/Assets/Textures/Background/icon9.png",
		"status": false
	}
};

func _ready():
	pass

func _init():
	rng.randomize()
	var my_random_number = rng.randi_range(1, total_level)
	current_level = my_random_number
	load_bg()
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
	
func load_bg():
	var file = File.new()
	file.open(bg_file, File.READ)
	
	var data = parse_json(file.get_line())
	if data == null:
		data = itemBackground
		
	var json := to_json(data)
	list_background = JSON.parse(json).result
	pass

func save_bg():
	pass
