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
			draw_circle(path[0] + Vector2(107, 90), 35, color)	
			for i in range(0, path.size() - 1, 1):
				draw_texture(image_texture, path[i+1] +  Vector2(0, -17))
				draw_circle(path[i + 1] + Vector2(107, 90), 35, color)
				if path.size() >= 2:
					draw_line(path[i] + Vector2(107, 90), path[i + 1] + Vector2(107, 90), color, 15 * 2, true)
			if is_touch and GameInstance.is_play:
				var array = PoolVector2Array( [ path[path.size() - 1] + Vector2(107, 90), get_global_mouse_position() ] )
				draw_polyline(array, color , 15 * 2, true)

func get_cell_texture() -> String:
	if GameInstance.diffcult == "Easy":
		return "res://src/Assets/Textures/Tilesets/dot2_216.png"
	elif GameInstance.diffcult == "Medium":
		return "res://src/Assets/Textures/Tilesets/dot2_180.png"
	elif GameInstance.diffcult == "Hard":
		return "res://src/Assets/Textures/Tilesets/dot2_154.png"
	elif GameInstance.diffcult == "Expert":
		return "res://src/Assets/Textures/Tilesets/dot2_135.png"
	else:
		return "res://src/Assets/Textures/Tilesets/dot2_120.png"
	
