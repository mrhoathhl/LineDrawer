extends Control

const ItemClass = preload("res://src/Scene/GamePlay/Item.gd");
const ItemSlotClass = preload("res://src/Scene/GamePlay/ItemSlot.gd");
onready var locked = preload("res://src/Assets/Textures/Button/lockBtn.png")

onready var background_grid = get_node("/root/GamePlayScene/ThemePopup/Panel/ListBackground")
var ring
var selected
var selected_pos;
var item_selected: ItemClass
signal on_change_theme(type)

func _ready():
	selected = Sprite.new()
	selected.texture = load("res://src/Assets/Textures/Background/Selected.png")
	selected.centered = true
	add_child(selected)
	
	ring = Sprite.new()
	ring.texture = load("res://src/Assets/Textures/Background/select.png")
	add_child(ring)
	
	
	for key in GameInstance.list_background:
		var item_slot = ItemSlotClass.new();
		var item = GameInstance.list_background[key];
		var item_name = item.itemName;
		var item_texture = item.itemIcon;
		var status = item.status;
		var is_selected = item.isSelected;
		
		item_slot.setItem(ItemClass.new(item_name, load(item_texture), status, is_selected));
			
		item_slot.connect("gui_input", self, "slot_gui_input", [item_slot]);
		background_grid.add_child(item_slot);
		
		if !item.status:
			item_slot.setItem(ItemClass.new(item_name, locked, null, null));
		if item.isSelected:
			selected_pos = item_slot.get_global_transform().origin 
			print(item_slot.rect_position)
	
	selected.transform.origin = Vector2(233.5, 571)
	ring.transform.origin = Vector2(233.5, 571)
	pass

func slot_gui_input(event : InputEvent, _slot: ItemSlotClass):
	if event is InputEvent:
		if event.is_pressed():
			if _slot.item:
				get_item_click(_slot.item)
		pass

func get_item_click(_item : ItemClass):
	if _item.item_status:
		item_selected = _item
		ring.transform.origin = _item.get_global_transform().origin
	else:
		pass
	
func _on_Select_pressed():
	SoundController.touch_sound()
	if item_selected != null:
		emit_signal("on_change_theme", item_selected.item_name)
		_on_ThemePopup_on_change_theme(item_selected.item_name)
		selected.transform.origin = item_selected.get_global_transform().origin

func _on_CloseThemePopup_pressed():
	SoundController.touch_sound()
	GameInstance.is_play = true;
	GameInstance.is_popup = false
	visible = false


func _on_ThemePopup_on_change_theme(type):
	print("pass", type)
	pass # Replace with function body.
