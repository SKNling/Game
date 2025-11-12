extends Node

func _ready():
	Global.loadData()
	
	primaryScene.connect('sceneChanged', Callable(self, 'sceneChangedProcess')) #[handlingSceneSwitching]
	
	
	if saveDataDebugging == false: #[saveDataDebugging]
		button.visible = false
		button2.visible = false
		button3.visible = false
		button4.visible = false
	elif saveDataDebugging:
		button.visible = true
		button2.visible = true
		button3.visible = true
		button4.visible = true
	else:
		print("Please check at saveDataDebugging")

#region [handlingSceneSwitching]


		 #VARIABLE#
@onready var sceneName : String = $".".name
@export var primaryScene : Node2D
@onready var animationPlayer = $AnimationPlayer
var secondaryScene = null
var secondarySceneName: String



		 #FUNCTION#
func sceneChangedProcess(primarySceneName: String):
	
	match primarySceneName:
		'loadingScreen':
			secondarySceneName = 'loadingScreen'
		'princessKidnapCutScene':
			secondarySceneName = "princessKidnapCutScene"
		"tower'sPracticeRoom":
			secondarySceneName = "tower'sPracticeRoom"
		"tower'sRoom1":
			secondarySceneName = "tower'sRoom1"
			animationPlayer.play("TowerFade")
		"tower'sRoom2":
			secondarySceneName = "tower'sRoom2"
			animationPlayer.play("TowerFade")
		"tower'sRoom3":
			secondarySceneName = "tower'sRoom3"
			animationPlayer.play("TowerFade")
		"tower'sRoom4":
			secondarySceneName = "tower'sRoom4"
			animationPlayer.play("TowerFade")
		"tower'sRoom5":
			secondarySceneName = "tower'sRoom5"
			animationPlayer.play("TowerFade")
		"tower'sRoom6":
			secondarySceneName = "tower'sRoom6"
			animationPlayer.play("TowerFade")
		"tower'sRoom7":
			secondarySceneName = "tower'sRoom7"
			animationPlayer.play("TowerFade")
		"tower'sRoom8":
			secondarySceneName = "tower'sRoom8"
			animationPlayer.play("TowerFade")
		"tower'sRoom9":
			secondarySceneName = "tower'sRoom9"
			animationPlayer.play("TowerFade")
		"tower'sRoom10":
			secondarySceneName = "tower'sRoom10"
			animationPlayer.play("TowerFade")
		_:
			print('error no matching scene name')
			return
			
	secondaryScene = load('res://Game/Scenes/' + secondarySceneName + '/' + secondarySceneName + '.tscn').instantiate()
	#secondaryScene.layer = -1
	secondaryScene.connect('sceneChanged', Callable(self, 'sceneChangedProcess'))
	
	
	await get_tree().create_timer(0.5).timeout
	primaryScene.clean_up()
	await primaryScene.clean_up()
	add_child(secondaryScene)
	
	primaryScene = secondaryScene
	#primaryScene.layer = 1
	
	
	secondaryScene = null
	#transfering_data_between_scenes(primaryScene, secondaryScene)



#endregion



#region [saveDataDebugging]


		 #VARIABLE#
@export var saveDataDebugging:bool
@onready var button = $Button
@onready var button2 = $Button2
@onready var button3 = $Button3
@onready var button4 = $Button4

		 #FUNCTION#
func _on_button_pressed():
	Global.loadData()
func _on_button_2_pressed():
	Global.saveData()
func _on_button_3_pressed():
	Global.debugNumber += 1
	Global.firstTime = !Global.firstTime
func _on_button_4_pressed():
	print(Global.debugNumber)
	print(Global.firstTime)


#endregion
