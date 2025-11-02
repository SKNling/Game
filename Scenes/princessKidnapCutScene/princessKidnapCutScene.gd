extends CanvasLayer



#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName = $".".name
var game_data = Global.game_data
signal sceneChanged(sceneName)
@onready var animation_player = $AnimationPlayer


		 #FUNCTION#
func _on_animation_player_animation_finished(anim_name):
	emit_signal('sceneChanged', sceneName)

#endregion
