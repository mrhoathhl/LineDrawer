extends Control

const ItemClass = preload("res://src/Scene/GamePlay/Item.gd");
const ItemSlotClass = preload("res://src/Scene/GamePlay/ItemSlot.gd");
onready var locked = preload("res://src/Assets/Textures/Button/lockBtn.png")

onready var background_grid = get_node("/root/GamePlayScene/ThemePopup/Panel/ListBackground")
var ring

func _ready():
	ring = Sprite.new()
	ring.texture = load("res://src/Assets/Textures/Background/select.png")
	add_child(ring)
	for key in GameInstance.list_background:
		var item_slot = ItemSlotClass.new();
		var item = GameInstance.list_background[key];
		var item_name = item.itemName;
		var item_texture = item.itemIcon;
		var status = item.status;
		item_slot.setItem(ItemClass.new(item_name, load(item_texture), status));
		if !item.status:
			item_slot.setItem(ItemClass.new(item_name, locked, status));
		item_slot.connect("gui_input", self, "slot_gui_input", [item_slot]);
		background_grid.add_child(item_slot);
	pass # Replace with function body.""

func slot_gui_input(event : InputEvent, _slot: ItemSlotClass):
	if event is InputEvent:
		if event.is_pressed():
			if _slot.item:
				get_item_click(_slot.item)
		pass

func get_item_click(_item : ItemClass):
	if _item.item_status:
		ring.transform.origin = _item.get_global_transform().origin + Vector2(ring.texture.get_width() / 2 - 43, ring.texture.get_height() / 2 - 20)
		print("open")
	else:
		print("lock")
	
func set_visible(status: bool):
	print(status)
	visible = status
	

func _on_Select_pressed():
	SoundController.touch_sound()
	GameInstance.is_play = false;
	GameInstance.is_popup = false
	$ThemePopup.visible = true

func _on_CloseThemePopup_pressed():
	SoundController.touch_sound()
	GameInstance.is_play = true;
	GameInstance.is_popup = false
	$ThemePopup.visible = false
