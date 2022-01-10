extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cursor = Vector2() #to be parsed
var grid = {} #dictionary to be parsed
var path = [] #pathfinder generated route
var is_win = false
var is_touch = false
var image_texture = ImageTexture.new()
var size_line = 30
var size_circle = 35
var line_pos = Vector2(107, 90)

# Called when the node enters the scene tree for the first time.
func _ready(): 
	var image = Image.new()
	image = load(get_cell_texture()).get_data()
	image.lock() # so i can modify pixel data
	image_texture.create_from_image(image)
	set_physics_process(true)
	
	
func _physics_process(delta):
	update() #draw each physics frame

func _draw():
	if !is_win: 
		var color = Color(1, 1, 1, 1)
		var size = Vector2(15,15)
		#draw route
		if path.size() >= 1:
			draw_texture(image_texture, path[0] + Vector2(0, -17))
			if GameInstance.is_play:
				draw_circle(path[0] + line_pos, size_circle, color)		
			for i in range(0, path.size() - 1, 1):
				draw_texture(image_texture, path[i+1] +  Vector2(0, -17))
				if GameInstance.is_play:
					draw_circle(path[i + 1] + line_pos, size_circle, color)
					if path.size() >= 2:
						draw_line(path[i] + line_pos, path[i + 1] + line_pos, color, size_line, true)

func get_cell_texture() -> String:
	if GameInstance.diffcult == "Easy":
		size_circle = 35
		size_line = 30
		line_pos = Vector2(107, 90)
		return "res://src/Assets/Textures/Tilesets/dot2_216.png"
	elif GameInstance.diffcult == "Medium":
		size_circle = 30
		size_line = 25
		line_pos = Vector2(89, 68)
		return "res://src/Assets/Textures/Tilesets/dot2_180.png"
	elif GameInstance.diffcult == "Hard":
		size_circle = 25
		size_line = 20
		line_pos = Vector2(76, 57)
		return "res://src/Assets/Textures/Tilesets/dot2_154.png"
	elif GameInstance.diffcult == "Expert":
		size_circle = 22
		size_line = 17
		line_pos = Vector2(68, 47)
		return "res://src/Assets/Textures/Tilesets/dot2_135.png"
	else:
		size_circle = 20
		size_line = 15
		line_pos = Vector2(60, 40)
		return "res://src/Assets/Textures/Tilesets/dot2_120.png"
	
