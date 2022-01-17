extends Control

const ItemClass = preload("res://src/Scene/GamePlay/Item.gd");
const ItemSlotClass = preload("res://src/Scene/GamePlay/ItemSlot.gd");
onready var locked = preload("res://src/Assets/Textures/Button/lockBtn.png")

onready var background_grid = get_node("/root/LevelSelectScene/Control/ScrollContainer/ListLevel")
# Called when the node enters the scene tree for the first time.
func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://src/Assets/Fonts/ARCO FOR OSX.OTF")
	dynamic_font.size = 120
	dynamic_font.outline_size = 5
	dynamic_font.outline_color = Color( 0, 0, 0, 1 )
	dynamic_font.use_filter = true
	var level_inx = 1;
	$HBoxContainer/Background.texture = GameInstance.theme
	for key in GameInstance.total_level:
		var item_slot = ItemSlotClass.new();
		item_slot.setItem(ItemClass.new(null, str(level_inx), GameInstance.icon, null, null, "level"));
		item_slot.connect("gui_input", self, "slot_gui_input", [item_slot]);
		background_grid.add_child(item_slot);
		if level_inx >= GameInstance.display_level:
			item_slot.setItem(ItemClass.new(null, str(level_inx), locked, null, null, "level"));
		else:
			var level_txt = Label.new()
			level_txt.add_font_override("font", dynamic_font)
			level_txt.text = str(level_inx)
			item_slot.add_child(level_txt)
		level_inx = level_inx + 1
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
