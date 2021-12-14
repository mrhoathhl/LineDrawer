extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cursor = Vector2() #to be parsed
var grid = {} #dictionary to be parsed
var path = [] #pathfinder generated route
const preload_Brick = preload("res://src/Object/Brick/Brick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready(): 
	
	set_physics_process(true)
	
	
func _physics_process(delta):
	update() #draw each physics frame



func _draw():
	
	var color = Color(.5,0,1)
	var size = Vector2(20,20)
	
	#draw route
	if path.size() >= 1:
		draw_rect(Rect2(path[0] + Vector2(22 ,7), size), color, false, 20, true)
		for i in range(0, path.size() - 1, 1):
			draw_rect(Rect2(path[i+1] +  Vector2(22 ,7), size), color, false, 20, true)
			draw_line(path[i] + Vector2(32,16), path[i + 1] + Vector2(33,16), color, 10 * 2, true)
