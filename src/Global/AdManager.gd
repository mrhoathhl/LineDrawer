extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal on_interstitial_close

var is_inter_ready = false;
var scene_path = ""
var inter_id = "a4743e6b23399810"
var banner_id = "4c218bb397c21994"
var reward_id = "4a6fc8f6d0c264e3"

# Called when the node enters the scene tree for the first time.
func _ready():
	applovin_max.loadInterstitial(inter_id, self.get_instance_id())
	applovin_max.loadBanner(banner_id, false, self.get_instance_id())
	applovin_max.loadRewardedVideo(reward_id, self.get_instance_id())

func load_inter():
	applovin_max.loadInterstitial(inter_id, self.get_instance_id())
	
func show_inter(id):
	print(abs(OS.get_ticks_msec() - Global.ad_time_last_show))
	if abs(OS.get_ticks_msec() - Global.ad_time_last_show) >= Global.time_interval and is_inter_ready:
		applovin_max.showInterstitial(id)
	else:
		emit_signal("on_interstitial_close")
		_on_Node_on_interstitial_close()
		
func _on_interstitial_loaded(id):
	is_inter_ready = true

func _on_interstitial_close(id):
	Global.ad_time_last_show = OS.get_ticks_msec()
	emit_signal("on_interstitial_close")
	_on_Node_on_interstitial_close()
	is_inter_ready = false
	load_inter()
	
func _on_interstitial_failed_to_load(id, error):
	is_inter_ready = false
	load_inter()
	
func _on_reward_loaded(id):
	pass
	
func _on_reward_failed(id):
	pass
	
func _on_reward_close(id):
	pass

func _on_Node_on_interstitial_close():
	pass
