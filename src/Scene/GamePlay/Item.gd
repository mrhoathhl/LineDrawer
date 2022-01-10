extends TextureRect

var selected_ring = preload("res://src/Assets/Textures/Background/select.png")
var current_selected = preload("res://src/Assets/Textures/Background/select.png")

var selected_ring_style: StyleBoxTexture = null
var current_selected_style: StyleBoxTexture = null

var item_name;
var item_status;

func _init(_item_name, _item_texture, _status):
	self.item_name = _item_name;
	texture = _item_texture;
	self.item_status = _status;
