extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var walkable = [0]
var grid = {}
var cursor = Vector2()

#reference
var start_point
var suggest_line
var path_finder

# Called when the node enters the scene tree for the first time.
func _ready():
	var tiles = get_used_cells()
	print(tiles)
	
	#get cell world pos, centralize and append to grid array
	for pos in tiles:
		var idx = get_cell(pos.x, pos.y)
		if walkable.has(idx):
			print("new_post")
			continue
			
		#else
		var new_pos = map_to_world(pos, false) #get world post
		new_pos = Vector2(new_pos.x, new_pos.y + 15) #centralize offset tile
		
		#grid is dictionary, make data array for each cell
		grid[new_pos] = ["empty", null]
		
	
	#define reference with group
	start_point = get_tree().get_nodes_in_group('StartPoint')[0]
	suggest_line = get_tree().get_nodes_in_group('Suggest')[0]
	path_finder = get_tree().get_nodes_in_group('PathFinder')[0]
	
	path_finder.locked.append(start_point.position)
	
	suggest_line.grid = grid 
	set_process(true) #cursor and player interactions
	set_process_input(true) #also cursor and player interactions
	

func _process(delta):
	
	#get map tile pos relative to mouse
	var tgt_cell = world_to_map( get_global_mouse_position() )
	
	
	#if tgt_cell is a valid cell (!= -1), sets it to cursor
	if get_cell(tgt_cell.x, tgt_cell.y) != -1:
		#get world position and centralize offset tile 
		cursor =  map_to_world(tgt_cell) + Vector2(0,15)
	else:
		cursor = Vector2() #unable it
	
	#parse cursor target to be drawn
	suggest_line.cursor = cursor
	var path = path_finder.searchs(start_point.position , cursor)
	suggest_line.path = path
	#print(path)

#features
func _input(event):

	#teleport player
	if event.is_action_pressed("mouse_act_left"):
		print("press")

	#generate path
	if event.is_action_released("mouse_act_left"):
		print("press")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
