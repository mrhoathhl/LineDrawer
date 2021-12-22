extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cursor = Vector2() #to be parsed
var grid = {} #dictionary to be parsed
var path = [] #pathfinder generated route
var is_win = false
var is_touch = false
var image = Image.new()
var image_texture = ImageTexture.new()

# Called when the node enters the scene tree for the first time.
func _ready(): 
	image.load("res://src/Map/Tilesets/player.png")
	image_texture.create_from_image(image)
	set_physics_process(true)
	
	
func _physics_process(delta):
	update() #draw each physics frame

func _input(event):
	if event is InputEventMouseMotion:
		pass

func _draw():
	if !is_win:
		var color = Color(.5,0,1, 0.9)
		var size = Vector2(15,15)
		#draw route
		if path.size() >= 1:
			draw_texture(image_texture, path[0] +  Vector2(22 ,7), color, image_texture)
			for i in range(0, path.size() - 1, 1):
				draw_line(path[i] + Vector2(32,16), path[i + 1] + Vector2(32,16), color, 10 * 2, true)
				draw_texture(image_texture, path[i+1] +  Vector2(22 ,7), color, image_texture)
				#draw_circle(path[i+1] +  Vector2(22 ,7), 20, color)
			if is_touch:
				var array = PoolVector2Array( [ path[path.size() - 1] + Vector2(32,16), get_global_mouse_position() ] )
				draw_polyline(array, color , 10 * 2, true)
