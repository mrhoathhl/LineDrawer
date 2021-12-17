extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var walkable = [0]
var grid = {}
var cursor = Vector2()
var is_win = false
#reference
var start_point
var suggest_line
var path_finder
var next_level
var brick_default = preload("res://src/Object/Brick/Brick.tscn")
var brick
var tween_scale_value = [1.4, 1.7]

# Called when the node enters the scene tree for the first time.
func _ready():
	var tiles = get_used_cells()
	brick = brick_default.instance()
	add_child(brick)
	#get cell world pos, centralize and append to grid array
	for pos in tiles:
		var idx = get_cell(pos.x, pos.y)
		if walkable.has(idx):
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
	
	path_finder.pos_check.append(start_point.position + Vector2(0, 15))
	path_finder.pos_line.append(start_point.position + Vector2(0, 15))
	
	var path = [start_point.position + Vector2(0, 15)]
	brick.transform.origin.x = start_point.position.x
	brick.transform.origin.y = start_point.position.y
	suggest_line.path = path
	suggest_line.grid = grid 
	set_process(true) #cursor and player interactions
	set_process_input(true) #also cursor and player interactions
	next_level = preload("res://src/Scene/Popup/NextLevel.tscn").instance()
	

func _process(delta):
	
	#get map tile pos relative to mouse
	var tgt_cell = world_to_map( get_global_mouse_position() )
	
	#if tgt_cell is a valid cell (!= -1), sets it to cursor
	if get_cell(tgt_cell.x, tgt_cell.y) != -1:
		#get world position and centralize offset tile 
		cursor =  map_to_world(tgt_cell) + Vector2(0,15)
	else:
		cursor = Vector2() #unable it

#features
func _input(event):
	if !is_win:
		if event is InputEventMouseMotion:
			if grid.has(cursor):
				var path = path_finder.search_point(cursor)
				suggest_line.path = path
				brick.transform.origin.x = path[path.size() - 1].x
				brick.transform.origin.y = path[path.size() - 1].y - 15
				if path.size() == grid.size():
					is_win = true
					yield(get_tree().create_timer(2.0), "timeout")
					suggest_line.is_win = true
					add_child(next_level)
				


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass