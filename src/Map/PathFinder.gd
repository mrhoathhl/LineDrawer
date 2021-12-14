extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var grid = get_tree().get_nodes_in_group("Tilemap")[0].grid 
var pos_check = [] #array of vect2 points, return final route
var pos_line = [] #array of vect2 points, return final route
var last_point

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func search_point(start_pos, target_pos):
	print(start_pos, " start")
	print(target_pos, " target")
	if grid.has(target_pos) && !pos_check.has(target_pos):
		if(check_valid_move(pos_check[pos_check.size() - 1], target_pos)):
			pos_check.append(target_pos)
	elif pos_check.has(target_pos):
		pos_check.resize(pos_check.find(target_pos) + 1)
	return pos_check

func check_valid_move(lastest_pos, target_pos):
	var next = Vector2(64, 64) 
	
	var step = target_pos - lastest_pos
	print(step, " neighbor")
	if abs(step.x) == abs(next.x) or abs(step.y) == abs(next.y):
		if lastest_pos.x == target_pos.x or lastest_pos.y == target_pos.y:
			return true
		
	#return array
	return false;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
