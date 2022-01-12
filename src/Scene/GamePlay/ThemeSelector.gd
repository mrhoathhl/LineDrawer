extends Control

const ItemClass = preload("res://src/Scene/GamePlay/Item.gd");
const ItemSlotClass = preload("res://src/Scene/GamePlay/ItemSlot.gd");
onready var locked = preload("res://src/Assets/Textures/Button/lockBtn.png")

onready var background_grid = get_node("/root/GamePlayScene/ThemePopup/Panel/ListBackground")
var ring
var selected
var selected_pos;
var item_selected: ItemClass
var current_theme
var selected_default
var theme_buy
signal on_change_theme(type)

func _ready():
	AdManager.connect("on_reward_rewarded", self, "_on_reward_rewarded_theme")
	pass

func slot_gui_input(event : InputEvent, _slot: ItemSlotClass):
	if event is InputEvent:
		if event.is_pressed():
			if _slot.item:
				get_item_click(_slot.item, _slot.get_transform().get_origin(), _slot)
		pass

func get_item_click(_item : ItemClass, pos: Vector2, _slot: ItemSlotClass):
	if _item.item_status:
		ring.visible = true
		item_selected = _item
		selected_default.get_child(1).visible = false
		ring.transform.origin = pos + Vector2(ring.texture.get_width() / 2 - 20, ring.texture.get_height() / 2 - 20)
	else:
		theme_buy = _slot
		SoundController.touch_sound()
		if AdManager.is_reward_ready:
			AdManager.show_reward(AdManager.reward_id)
		pass
	
func _on_Select_pressed():
	SoundController.touch_sound()
	if item_selected != null:
		selected.visible = true
		selected_default.get_child(2).visible = false
		emit_signal("on_change_theme", item_selected.item_name)
		_on_ThemePopup_on_change_theme(item_selected.item_name)
		GameInstance.list_data.themes[0][current_theme].isSelected = false
		GameInstance.list_data.themes[0][item_selected.item_key].isSelected = true
		selected.transform.origin = ring.transform.origin
		GameInstance.save_bg()
		current_theme = item_selected.item_key
		
func _on_CloseThemePopup_pressed():
	SoundController.touch_sound()
	remove_all_child()
	GameInstance.is_play = true;
	GameInstance.is_popup = false
	visible = false
	
func _on_reward_rewarded_theme():
	remove_all_child()
	theme_buy.get_child(1).visible = false
	theme_buy.get_child(2).visible = false
	GameInstance.list_data.themes[0][theme_buy.item.item_key].status = true
	GameInstance.save_bg()
	_on_ThemePopup_visibility_changed()

func remove_all_child():
	for n in background_grid.get_children():
		background_grid.remove_child(n)
		n.queue_free()

func _on_ThemePopup_on_change_theme(type):
	pass # Replace with function body.


func _on_ThemePopup_visibility_changed():
	if background_grid.get_child_count() == 0:
		selected = Sprite.new()
		selected.texture = load("res://src/Assets/Textures/Background/Selected.png")
		selected.visible = false
		selected.centered = true
		
		ring = Sprite.new()
		ring.centered = true
		ring.visible = false
		ring.texture = load("res://src/Assets/Textures/Background/select.png")
		
		for key in GameInstance.list_background:
			var item_slot = ItemSlotClass.new();
			var item = GameInstance.list_background[key];
			var item_key = key;
			var item_name = item.itemName;
			var item_texture = item.itemIcon;
			var status = item.status;
			var is_selected = item.isSelected;
			item_slot.setItem(ItemClass.new(item_key, item_name, load(item_texture), status, is_selected));
			
			item_slot.connect("gui_input", self, "slot_gui_input", [item_slot]);
			background_grid.add_child(item_slot);
			
			if !item.status:
				item_slot.setItem(ItemClass.new(item_key, item_name, locked, status, is_selected));
				item_slot.setItem(ItemClass.new(item_key, "video", load("res://src/Assets/Textures/Button/WatchADS2.png"), status, is_selected));
			if item.isSelected:
				current_theme = key
				item_slot.setItem(ItemClass.new(item_key, "select", load("res://src/Assets/Textures/Background/select.png"), status, is_selected));
				item_slot.setItem(ItemClass.new(item_key, "Selected", load("res://src/Assets/Textures/Background/Selected.png"), status, is_selected));

				selected_default = item_slot
		background_grid.add_child(selected)
		background_grid.add_child(ring)
	pass # Replace with function body.
