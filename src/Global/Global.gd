extends Node2D
var current_level = 1
var total_level = 20
var display_level = 1
var game_file = "user://gamedata.dat"
var diffcult = "Easy"

var rng = RandomNumberGenerator.new()
var is_reload = false
var is_play = true
var is_sound_on = true

onready var vp = get_tree().get_root()
onready var base_size = Vector2(1080, 1920)

func _ready():
	# Use whichever you would like by default
	#set_fullscreen()
	set_windowed()

func _init():
	rng.randomize()
	var my_random_number = rng.randi_range(1, total_level)
	current_level = my_random_number
	load_current_level()
	print("ccc")
	pass
	
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

func set_fullscreen():
	var window_size = OS.get_screen_size()
	print(window_size)
	if OS.get_name() == 'Windows' && window_size == base_size:
				# Not sure if this works outside of Windows / native resolution.
				#  - Mac didn't like it, nor smaller resolutions.
		OS.set_window_fullscreen(true)
	
	else:
		var scale = min(window_size.x / base_size.x, window_size.y / base_size.y)
		var scaled_size = (base_size * scale).round()
		
		var margins = Vector2(window_size.x - scaled_size.x, window_size.y - scaled_size.y)
		var screen_rect = Rect2((margins / 2).round(), scaled_size)
		
		OS.set_borderless_window(true)
		OS.set_window_position(OS.get_screen_position())
		OS.set_window_size(Vector2(window_size.x, window_size.y + 1)) # Black magic?
		vp.set_size(scaled_size) # Not sure this is strictly necessary
		vp.set_attach_to_screen_rect(screen_rect)


func set_windowed():
	var window_size = OS.get_screen_size()
		# I set the windowed version to an arbitrary 80% of screen size here
	var scale = min(window_size.x / base_size.x, window_size.y / base_size.y) * 0.8
	var scaled_size = (base_size * scale).round()
	
	var window_x = (window_size.x / 2) - (scaled_size.x / 2)
	var window_y = (window_size.y / 2) - (scaled_size.y / 2)
	OS.set_borderless_window(false)
	OS.set_window_fullscreen(false)
	OS.set_window_position(Vector2(window_x, window_y))
	OS.set_window_size(scaled_size)
	vp.set_size(scaled_size)
