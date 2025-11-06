extends Node2D



#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName = $".".name
var game_data = Global.game_data
signal sceneChanged(sceneName)
@onready var animation_player = $AnimationPlayer
@onready var cam1 = $cam1
@onready var cam2 = $cam2


		 #FUNCTION#
func _process(delta):
	if animation_player.is_playing() and Input.is_action_just_pressed("interact"):
		emit_signal('sceneChanged', sceneName)
func _on_animation_player_animation_finished(anim_name):
	emit_signal('sceneChanged', sceneName)
func clean_up():
	queue_free()


#endregion
