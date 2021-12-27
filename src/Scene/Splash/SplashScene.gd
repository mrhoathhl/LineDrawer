extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	print(applovin_max.loadBanner("1e5566a719a445cf", false, 0))
	applovin_max.loadInterstitial("f20db4009e262ded", 1)
	applovin_max.loadRewardedVideo("b4338b94fca5d075", 2)

func _on_Timer_timeout():
	$ProgressBar.value += 1
	if $ProgressBar.value == 100:
		yield(get_tree().create_timer(0.5), "timeout")
		SceneManager.transition(SceneManager.home_scene)
