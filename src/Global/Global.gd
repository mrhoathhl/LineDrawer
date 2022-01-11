extends Node2D
var total_level = 50
var display_level = 1
var bg_file = "user://userdata.json"
var diffcult = "Easy"
var ad_time_last_show = 0
var time_interval = 20000
var theme = load("res://src/Assets/Textures/Background/bg1.png")

var is_reload = false
var is_play = true
var is_popup = false
var is_sound_on = true
var list_background : Dictionary
var list_level : Dictionary
var list_data : Dictionary

const default_data = {
	"themes": [
		{
			"0": { "isSelected": true, "itemIcon": "res://src/Assets/Textures/Background/icon1.png", "itemName": "bg1", "status": true },
			"1": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon2.png", "itemName": "bg2", "status": true },
			"2": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon3.png", "itemName": "bg3", "status": true },
			"3": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon4.png", "itemName": "bg4", "status": false },
			"4": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon5.png", "itemName": "bg5", "status": false },
			"5": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon6.png", "itemName": "bg6", "status": false },
			"6": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon7.png", "itemName": "bg7", "status": false },
			"7": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon8.png", "itemName": "bg8", "status": false },
			"8": { "isSelected": false, "itemIcon": "res://src/Assets/Textures/Background/icon9.png", "itemName": "bg9", "status": false }
		}
	],
	"levels": [
		{
			"Easy": 1,
			"Medium": 1,
			"Hard": 1,
			"Expert": 1,
			"Pro": 1,
		}
	]
}

func _ready():
	pass

func _init():
	load_bg()

func load_bg():
	var file = File.new()
	file.open(bg_file, File.READ)
	
	var data = parse_json(file.get_line())
	if data == null:
		data = default_data
		
	var json := to_json(data)
	list_data = JSON.parse(json).result
	list_level = list_data.levels[0]
	list_background = list_data.themes[0]
	for key in list_background:
		if list_background[key].isSelected:
			theme = load("res://src/Assets/Textures/Background/" + list_background[key].itemName + ".png")

func save_bg():
	var file = File.new()
	file.open(bg_file, File.WRITE)
	file.store_line(to_json(list_data))
	pass
