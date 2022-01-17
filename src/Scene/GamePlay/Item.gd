extends TextureRect

var selected_ring = preload("res://src/Assets/Textures/Background/select.png")
var current_selected = preload("res://src/Assets/Textures/Background/select.png")

var selected_ring_style: StyleBoxTexture = null
var current_selected_style: StyleBoxTexture = null

var item_key
var item_name;
var item_status;
var is_selected;

func _init(_key, _item_name, _item_texture, _status, _is_selected, type):
	self.item_key = _key
	self.item_name = _item_name;
	texture = _item_texture;
	self.item_status = _status;
	self.is_selected = _is_selected;
	var name = _item_name
	if type == "level":
		set_scale(Vector2(0.7, 0.7))
		anchor_left = 0.5
		anchor_right = 0.5
		anchor_top = 0.5
		anchor_bottom = 0.5
	if _item_name.length() > 8:
		name = _item_name.split("_")[0]
	if name == "Selected":
		rect_position = Vector2(48, 50)
	elif name == "select":
		rect_position = Vector2(-20, -20)
	elif name == "video":
		rect_position = Vector2(-20, -20)

	
