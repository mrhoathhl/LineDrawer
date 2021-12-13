extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton:
		if event.is_pressed():
			print(shape_idx)
			print("Object Click")
			print(viewport)
		else:
			print("Object Released")
