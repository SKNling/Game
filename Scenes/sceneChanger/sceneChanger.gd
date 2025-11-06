extends Node



#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName : String = $".".name
@export var primaryScene : Node2D
@onready var animationPlayer = $AnimationPlayer
var secondaryScene = null
var secondarySceneName: String
var game_data = Global.game_data



		 #FUNCTION#
func _ready():
	primaryScene.connect('sceneChanged', Callable(self, 'sceneChangedProcess'))
	Global.load_game_data()
	
func sceneChangedProcess(primarySceneName: String):
	
	match primarySceneName:
		'loadingScreen':
			secondarySceneName = 'princessKidnapCutScene'
		'princessKidnapCutScene':
			secondarySceneName = "tower'sPracticeRoom"
		"tower'sPracticeRoom":
			secondarySceneName = "tower'sRoom1"
		"tower'sRoom1":
			secondarySceneName = "tower'sRoom2"
		_:
			print('error no matching scene name')
			return
			
	secondaryScene = load('res://Game/Scenes/' + secondarySceneName + '/' + secondarySceneName + '.tscn').instantiate()
	#secondaryScene.layer = -1
	secondaryScene.connect('sceneChanged', Callable(self, 'sceneChangedProcess'))
	
	if primarySceneName != 'loadingScreen':
		animationPlayer.play("TowerFade")
	await get_tree().create_timer(0.5).timeout
	primaryScene.clean_up()
	await primaryScene.clean_up()
	add_child(secondaryScene)
	
	primaryScene = secondaryScene
	#primaryScene.layer = 1
	
	
	secondaryScene = null
	#transfering_data_between_scenes(primaryScene, secondaryScene)



#endregion











	
#func _on_animation_player_animation_finished(anim_name):
	#match anim_name:
		#'fade_in':
			##print("'fade_in' animation finished!")
			#primaryScene.clean_up()
			##print('primaryScene' + " '" + str(primaryScene) + "'" + 'cleaned up!')
			#primaryScene = secondaryScene
			##print("changing 'primaryScene' to 'secondaryScene', " + str(primaryScene) + ' -> ' + str(secondaryScene))
			#primaryScene.layer = 1
			##print("'" + str(primaryScene) + "'" + " scene's layer set back to 1!")
			#secondaryScene = null
			##print("changed 'secondaryScene' -> " + str(secondaryScene))
			#anim.play("fade_out")
			##print("'fade_out' animation played!")
		#'fade_out':
			#pass
			##print("'fade_out' animation finished!")


func transfering_data_between_scenes(old_scene, new_scene):
	new_scene.load_game_data(old_scene.game_data)
	new_scene.game_data = Global.game_data
