extends Node

onready var tap_sound_pre = preload("res://src/Assets/Sounds/Tap_dot.ogg")

func tap_sound():
	if Global.is_sound_on:
		var tap = AudioStreamPlayer.new()
		add_child(tap)
		tap.stream = tap_sound_pre
		tap.play()
		yield(tap, "finished")
		remove_child(tap)
	
func win_sound():
	if Global.is_sound_on:
		$Win.play()
	
func next_sound():
	if Global.is_sound_on:
		$Next.play()

func touch_sound():
	if Global.is_sound_on:
		$Touch.play()
