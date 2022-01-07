extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var grid = get_tree().get_nodes_in_group("Tilemap")[0].grid 
var pos_check = [] #array of vect2 points, return final route
var last_point
var next

# Called when the node enters the scene tree for the first time.
func _ready():
	next = get_cell_step()
	print(next)


func search_point(target_pos):
	if grid.has(target_pos) && !pos_check.has(target_pos):
		if(check_valid_move(pos_check[pos_check.size() - 1], target_pos)):
			pos_check.append(target_pos)
			#SoundController.tap_sound()
	elif pos_check.has(target_pos):
		pos_check.resize(pos_check.find(target_pos) + 1)
	return pos_check

func check_valid_move(lastest_pos, target_pos):
	var step = target_pos - lastest_pos
	print("target ", target_pos)
	print("lastest ", lastest_pos)
	print(step)
	if abs(step.x) == abs(next.x) or abs(step.y) == abs(next.y):
		if lastest_pos.x == target_pos.x or lastest_pos.y == target_pos.y:
			return true
	#return array
	return false;

func get_cell_step() -> Vector2:
	if GameInstance.diffcult == "Easy":
		return Vector2(216, 216)
	elif GameInstance.diffcult == "Medium":
		return Vector2(180, 180)
	elif GameInstance.diffcult == "Hard":
		return Vector2(154, 154)
	elif GameInstance.diffcult == "Expert":
		return Vector2(135, 135)
	else:
		return Vector2(120, 120) 
