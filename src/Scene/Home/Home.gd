extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Help_pressed():
	print("Help")


func _on_Play_pressed():
	$Label.text = "cl;cickc"
	pass # Replace with function body.


func _on_Button_pressed():
	$Label.text = "cl;cickc"
