extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal on_interstitial_close
signal on_reward_close
signal on_reward_rewarded

var time_stamp = 0
var is_inter_ready = false;
var is_reward_ready = false;
var scene_path = ""
var inter_id = "a4743e6b23399810"
var banner_id = "4c218bb397c21994"
var reward_id = "4a6fc8f6d0c264e3"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready load ad")
	print(applovin_max.loadInterstitial(inter_id, self.get_instance_id()))
	applovin_max.loadBanner(banner_id, false, self.get_instance_id())
	applovin_max.loadRewardedVideo(reward_id, self.get_instance_id())

func load_inter():
	applovin_max.loadInterstitial(inter_id, self.get_instance_id())
	
func load_reward():
	applovin_max.loadRewardedVideo(reward_id, self.get_instance_id())
	
func show_banner():
	applovin_max.showBanner(banner_id)
	
func show_inter(id):
	if abs(OS.get_ticks_msec() - GameInstance.ad_time_last_show) >= GameInstance.time_interval and is_inter_ready:
		applovin_max.showInterstitial(id)
	else:
		emit_signal("on_interstitial_close")
		_on_Node_on_interstitial_close()
		
func show_reward(id):
	if is_reward_ready:
		applovin_max.showRewardedVideo(id)
	else:
		emit_signal("on_reward_failed")
		_on_Node_on_reward_close()
		
func _on_interstitial_loaded(id):
	print("inter loaded")
	is_inter_ready = true

func _on_interstitial_close(id):
	GameInstance.ad_time_last_show = OS.get_ticks_msec()
	emit_signal("on_interstitial_close")
	_on_Node_on_interstitial_close()
	is_inter_ready = false
	load_inter()
	
func _on_interstitial_failed_to_load(id, error):
	print("inter load failed")
	time_stamp += 1
	is_inter_ready = false
	yield(get_tree().create_timer(time_stamp), "timeout")
	load_inter()
	
func _on_rewarded_video_ad_loaded(id):
	print("reward loaded")
	is_reward_ready = true
	
func _on_rewarded_video_ad_failed_to_load(id):
	is_reward_ready = false
	load_reward()
	
func _on_rewarded_video_ad_closed(id):
	emit_signal("on_reward_close")
	_on_Node_on_reward_close()
	is_reward_ready = false
	load_reward()
	
func _on_rewarded_video_completed(id: String):
	emit_signal("on_reward_rewarded")
	_on_Node_on_reward_rewarded()


func _on_Node_on_interstitial_close():
	pass


func _on_Node_on_reward_close():
	pass # Replace with function body.


func _on_Node_on_reward_rewarded():
	pass # Replace with function body.
