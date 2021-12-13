extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var grid = get_tree().get_nodes_in_group("Tilemap")[0].grid 
var locked = [] #array of vect2 points, return final route

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func searchs(start_pos, target_pos):
	if grid.has(target_pos):
		if !locked.has(target_pos):
				locked.append(target_pos)
				#if locked.size() > 0:
					#if check_valid_move(locked[locked.size()-1], target_pos):
						#locked.insert(locked.size() , target_pos)
				#else:
					#locked.insert(locked.size() , target_pos)
		else:
			if !locked.has(target_pos):
					locked.append(target_pos)
			else:
				locked.resize(locked.find(target_pos))
	return locked

func check_valid_move(lastest_pos, target_pos):
	
	#minimum distance between cells
	var next = Vector2(30,15) 
	print(target_pos, " targetx")
	print(lastest_pos, " targetx")
	if target_pos.x == lastest_pos.x:
		print(target_pos, " targetx")
		print(lastest_pos, " targetx")
		if target_pos == lastest_pos * next:
			return true
	elif target_pos.y == lastest_pos.y:
		print(target_pos, " targety")
		print(lastest_pos, " targety")
		if target_pos == lastest_pos * next:
			return true
	else:
		return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
