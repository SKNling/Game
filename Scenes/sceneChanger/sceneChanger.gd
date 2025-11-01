extends Node

var next_scene = null
var next_scene_name: String
@onready var anim = $AnimationPlayer
@onready var current_scene = $LoadingScreen


func _ready():
	current_scene.connect('scene_changed', Callable(self, 'handle_scene_changed'))
	Global.load_game_data()
	#print('game_data loaded!')





func handle_scene_changed(current_scene_name: String):
	#print("signal 'scene_changed' recieved! changing value 'scene_name' -> 'current_scene_name' = ", current_scene_name)
	match current_scene_name:
		'loadingScreen':
			next_scene_name = 'forest'
		_:
			print('error no matching scene name :(')
			return
	#print("loading next scene, 'next_scene' = " + str(next_scene) + '!')
	next_scene = load('res://Game/Scenes/' + next_scene_name + '/' + next_scene_name + '.tscn').instantiate()
	#print("loading next scene, 'next_scene' = " + str(next_scene_name) + ', instantiated!')
	next_scene.layer = -1
	#print("'" + str(next_scene_name) + "'" + " scene's layer set to -1!")
	add_child(next_scene)
	#print("'" + str(next_scene_name) + "'" + "scene, added to parent 'scene switcher'!")
	#anim.play('fade_in')
	current_scene.clean_up()
	current_scene = next_scene
	current_scene.layer = 1
	#print("'fade_in' animation played!")
	next_scene.connect('scene_changed', Callable(self, 'handle_scene_changed'))
	
	#print("signal 'scene_changed' has been wired to " + next_scene_name + "! with value 'scene_name' = " + current_scene_name + " from " + "'" + current_scene_name + "'")
	transfering_data_between_scenes(current_scene, next_scene)
	next_scene = null
	
#func _on_animation_player_animation_finished(anim_name):
	#match anim_name:
		#'fade_in':
			##print("'fade_in' animation finished!")
			#current_scene.clean_up()
			##print('current_scene' + " '" + str(current_scene) + "'" + 'cleaned up!')
			#current_scene = next_scene
			##print("changing 'current_scene' to 'next_scene', " + str(current_scene) + ' -> ' + str(next_scene))
			#current_scene.layer = 1
			##print("'" + str(current_scene) + "'" + " scene's layer set back to 1!")
			#next_scene = null
			##print("changed 'next_scene' -> " + str(next_scene))
			#anim.play("fade_out")
			##print("'fade_out' animation played!")
		#'fade_out':
			#pass
			##print("'fade_out' animation finished!")


func transfering_data_between_scenes(old_scene, new_scene):
	new_scene.load_game_data(old_scene.game_data)
	new_scene.game_data = Global.game_data
