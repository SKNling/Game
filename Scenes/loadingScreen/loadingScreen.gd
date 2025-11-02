extends Node2D



#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName = $".".name
var game_data = Global.game_data
signal sceneChanged(sceneName)
@onready var buttonSound1 = $play_button/button1Sound
@onready var animationPlayer = $AnimationPlayer


		 #FUNCTION#
func _on_play_button_pressed():
	buttonSound1.play()
	animationPlayer.play("fade_out")
	emit_signal('sceneChanged', sceneName)
func clean_up():
	if buttonSound1.playing:
		await buttonSound1.finished
	queue_free()

#endregion



#region Section - How to Play


		 #VARIABLE#
@onready var howToPlayWindow = $howToPlayWindow


		 #FUNCTION#
func _on_how_to_play_button_pressed():
	howToPlayWindow.visible = true
func _on_how_to_play_window_close_requested():
	howToPlayWindow.visible = false


#endregion
