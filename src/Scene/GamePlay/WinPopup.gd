extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var my_random_number = rng.randi_range(1, 9)
	$Control/Icon.texture = load("res://src/Assets/Textures/Icon/icon" + str(my_random_number) + ".png")
	pass # Replace with function body.

func _on_Next_pressed():
	SoundController.touch_sound()
	GameInstance.is_reload = false
	GameInstance.is_play = true
	GameInstance.display_level += 1
	get_parent().save_current_level()
	if AdManager.is_inter_ready:
		if GameInstance.display_level == 50:
			GameInstance.type = "pass"
		else:
			GameInstance.type = "next"
		AdManager.show_inter(AdManager.inter_id)
	else:
		visible = false
		get_tree().reload_current_scene()

func save_current_level():
	if GameInstance.diffcult == "Easy":	
		GameInstance.list_data.levels[0].Easy = GameInstance.display_level
	elif GameInstance.diffcult == "Medium":
		GameInstance.list_data.levels[0].Medium = GameInstance.display_level
	elif GameInstance.diffcult == "Hard":
		GameInstance.list_data.levels[0].Hard = GameInstance.display_level
	elif GameInstance.diffcult == "Expert":
		GameInstance.list_data.levels[0].Expert = GameInstance.display_level
	else:
		GameInstance.list_data.levels[0].Professor = GameInstance.display_level
	GameInstance.save_bg()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
