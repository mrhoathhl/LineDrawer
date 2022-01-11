extends TileMap

var walkable = [0]
var grid = {}
var cursor = Vector2()
var is_win = false
#reference
var start_point
var suggest_line
var path_finder
var game_play
var brick_fading_tscn = preload("res://src/Object/FadingBrick/FadingBrick.tscn")
var glow_ring_tscn = preload("res://src/Object/Ring/Ring.tscn")
var brick_pos
var origin_array = []
var tween_scale_value = [1.4, 1.7]
var size_pos;

# Called when the node enters the scene tree for the first time.
func _ready():
	var tiles = get_used_cells()
	brick_pos = get_brick_pos()
	#get cell world pos, centralize and append to grid array
	for pos in tiles:
		var idx = get_cell(pos.x, pos.y)
		if !walkable.has(idx):
			continue
			
		#else
		var new_pos = map_to_world(pos, false) #get world post
		new_pos = Vector2(new_pos.x, new_pos.y + 15) #centralize offset tile
		origin_array.append(new_pos)
		#grid is dictionary, make data array for each cell
		grid[new_pos] = ["empty", null]
	
	#define reference with group
	start_point = get_tree().get_nodes_in_group('StartPoint')[0]
	suggest_line = get_tree().get_nodes_in_group('Suggest')[0]
	path_finder = get_tree().get_nodes_in_group('PathFinder')[0]
	game_play = get_tree().get_nodes_in_group('GamePlay')[0]
	
	game_play.connect("on_hint_click", self, "_on_hint_click")
	start_point.modulate = Color(1, 1, 1, 0)
	path_finder.pos_check.append(start_point.position + Vector2(0, 15))
	var path = [start_point.position + Vector2(0, 15)]
	suggest_line.path = path
	suggest_line.grid = grid 
	set_process(true) #cursor and player interactions
	set_process_input(true) #also cursor and player interactions
	
func _process(delta):
	
	#get map tile pos relative to mouse
	var tgt_cell = world_to_map( get_global_mouse_position() )
	
	#if tgt_cell is a valid cell (!= -1), sets it to cursor
	if get_cell(tgt_cell.x, tgt_cell.y) != -1:
		#get world position and centralize offset tile 
		cursor =  map_to_world(tgt_cell) + Vector2(0, 15)
	else:
		cursor = Vector2() #unable it
		
		
func _input(event):
	if !suggest_line.is_win && GameInstance.is_play:
		if event is InputEventMouseMotion or event is InputEvent:
			if grid.has(cursor):
				var path = path_finder.search_point(cursor)
				if size_pos != path.size():
					SoundController.tap_sound()
					Input.vibrate_handheld(30)
					size_pos = path.size()
				suggest_line.path = path
				if path.size() == grid.size():
					GameInstance.is_play = false
					yield(get_tree().create_timer(.2), "timeout")
					SoundController.next_sound()
					clear_map()

func clear_map():
	for i in range(0, origin_array.size(), 1):
		var ring = glow_ring_tscn.instance()
		ring.transform.origin = origin_array[i] + brick_pos
		add_child(ring)
		yield(get_tree().create_timer(1.0 / origin_array.size()), "timeout")
		
	for i in range(0, origin_array.size(), 1):
		var tile = world_to_map(origin_array[i])
		set_cell(tile.x, tile.y, -1)
		
		var brick_fading = brick_fading_tscn.instance()
		brick_fading.transform.origin = origin_array[i] + brick_pos
		add_child(brick_fading)
		
		suggest_line.path.erase(origin_array[i])
		yield(get_tree().create_timer(1.0 / origin_array.size()), "timeout")
	yield(get_tree().create_timer(0.7), "timeout")
	suggest_line.is_win = true
	get_parent().get_parent().get_parent().get_node("WinPopup").visible = true
	
func _on_hint_click():
	var tile_left = origin_array.size() - suggest_line.path.size()
	if tile_left > 0:
		for i in range(suggest_line.path.size(), origin_array.size(), 1):
			var path = path_finder.search_point(origin_array[i])
			suggest_line.path = path
			yield(get_tree().create_timer(1), "timeout")
	pass
	
func get_brick_pos() -> Vector2:
	if GameInstance.diffcult == "Easy":
		return Vector2(107, 90)
	elif GameInstance.diffcult == "Medium":
		return Vector2(89, 72)
	elif GameInstance.diffcult == "Hard":
		return Vector2(76, 59)
	elif GameInstance.diffcult == "Expert":
		return Vector2(68, 47)
	else:
		return Vector2(60, 40)
