extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var walkable = [0]
var gridObject = {}
var cursor = Vector2()

#reference
var start_point
var suggest_line
var path_finder

# Called when the node enters the scene tree for the first time.
func _ready():
	print("tiles")
	var tiles = get_used_cells()
	print(tiles)
	
	#get cell world pos, centralize and append to grid array
	for pos in tiles:
		var idx = get_cell(pos.x, pos.y)
		if !walkable.has(idx):
			continue
			
		#else
		var new_pos = map_to_world(pos, false) #get world post
		new_pos = Vector2(new_pos.x, new_pos.y + 15) #centralize offset tile
		
		#grid is dictionary, make data array for each cell
		gridObject[new_pos] = ["empty", null]
		
	print(gridObject)
	
	#define reference with group
	start_point = get_tree().get_nodes_in_group('StartPoint')
	suggest_line = get_tree().get_nodes_in_group('Suggest')
	path_finder = get_tree().get_nodes_in_group('PathFinder')
	
	
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
