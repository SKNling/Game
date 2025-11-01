extends CanvasLayer

var scene_name = 'loadingScreen'
var game_data = Global.game_data
signal scene_changed(scene_name)
#@onready var play_button = $play_button
#@onready var button_click_sound_1 = $button_click_1
#@onready var เหรียญ_label = $"เหรียญ_label"
#@onready var loading_screen_music = $loading_screen_music



func _on_play_button_pressed():
		#print("play button pressed!")
		#button_click_sound_1.play()
		#print("button_click_sound_1 played!")
		#play_button.disabled = true
		#print("play button disabled = true!")
		#print("signal 'scene_changed' emitting!, value -> 'scene_name' = 'loading screen'")
		emit_signal('scene_changed', scene_name)
	
func clean_up():
	#if button_click_sound_1.playing:
		#await button_click_sound_1.finished
	queue_free()



#func load_game_data(new_game_data: Dictionary):
	#game_data = new_game_data
	##print("game_data = new_game_data!")
	#เหรียญ_label.text = 'เหรียญ ' + str(game_data.เหรียญ)
	##print('เหรียญ_label.text has been updated!')
#
#
#
#func _on_loading_screen_music_finished(seconds):
	#await get_tree().create_timer(seconds).timeout
	#loading_screen_music.play()
