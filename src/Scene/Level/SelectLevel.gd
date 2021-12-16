extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var back_btn = get_node("Back")
onready var container_level = get_node("Control/HBoxContainer/GridContainer")
var select_level_tscn = preload("res://src/Object/SelectBtn/SelectButton.tscn")


	
# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in range(0, 50, 1):
		var select_level = select_level_tscn.instance()
		select_level.get_node("Control/TouchScreenButton/Label").text = str(cell)
		container_level.add_child(select_level)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	print("Back")


func _on_Setting_pressed():
	print("Setting")
