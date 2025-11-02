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
func _on_animation_player_animation_finished(anim_name):
	emit_signal('sceneChanged', sceneName)


#endregion
