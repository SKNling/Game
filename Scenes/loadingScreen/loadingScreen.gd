extends Node2D

func _ready():
	pass

#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName = $".".name
@onready var goToScene = "princessKidnapCutscene"
signal sceneChanged(sceneName)
@onready var buttonSound1 = $play_button/button1Sound
@onready var animationPlayer = $AnimationPlayer



		 #FUNCTION#
func checkFirstTime():
	if Global.firstTime == false:
		goToScene = "tower'sPracticeRoom"
	elif Global.firstTime:
		goToScene = "princessKidnapCutScene"
		Global.firstTime = false
		Global.saveData()
	else:
		print("loadingScreen.gd checkFirstTime error")
	
func _on_play_button_pressed():
	checkFirstTime()
	buttonSound1.play()
	animationPlayer.play("fade_out")
	emit_signal('sceneChanged', goToScene)
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
