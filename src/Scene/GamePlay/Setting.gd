extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var tween_node = Tween.new()
var scale_step = [Vector2(1, 1), Vector2(1.05, 1.05)]

# Called when the node enters the scene tree for the first time.
func _ready():	
	add_child(tween_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Setting_button_down():
	pass

