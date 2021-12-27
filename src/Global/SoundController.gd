extends Node

func tap_sound():
	if Global.is_sound_on:
		$Tap.play()
	
func win_sound():
	if Global.is_sound_on:
		$Win.play()
	
func next_sound():
	if Global.is_sound_on:
		$Next.play()

func touch_sound():
	if Global.is_sound_on:
		$Touch.play()
