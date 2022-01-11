extends TextureRect

var selected_ring = preload("res://src/Assets/Textures/Background/select.png")
var current_selected = preload("res://src/Assets/Textures/Background/select.png")

var selected_ring_style: StyleBoxTexture = null
var current_selected_style: StyleBoxTexture = null

var item_key
var item_name;
var item_status;
var is_selected;

func _init(_key, _item_name, _item_texture, _status, _is_selected):
	self.item_key = _key
	self.item_name = _item_name;
	texture = _item_texture;
	self.item_status = _status;
	self.is_selected = _is_selected;
	if _item_name == "Selected":
		rect_position = Vector2(48, 50)
	elif _item_name == "select":
		rect_position = Vector2(-20, -20)
	
