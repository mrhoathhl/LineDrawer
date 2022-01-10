extends Panel

var slotIndex;
var item = null;
var style;

func _init():
	mouse_filter = Control.MOUSE_FILTER_PASS;
	rect_min_size = Vector2(34, 34);
	style = StyleBoxEmpty.new();
	set('custom_styles/panel', style);

func setItem(newItem):
	add_child(newItem);
	item = newItem;

func pickItem():
	item.pickItem();
	remove_child(item);
	get_tree().get_root().add_child(item);
	item = null;

func removeItem(newItem):
	remove_child(newItem);
	newItem = null;
