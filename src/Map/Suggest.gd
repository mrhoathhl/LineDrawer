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
	var size = Vector2(60,60)
	
	#draw route
	if path.size() >= 1:
		
		for pos in path:
			#var level = preload_Brick.instance()
			#level.position = pos
			#add_child(level)
			draw_style_box(StyleBoxFlat.new(), Rect2(pos + Vector2(0,10), size))
			#draw_circle(pos, size, color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
