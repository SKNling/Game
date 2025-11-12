extends Node2D



#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName = $".".name
@export var goToScene = "tower'sPracticeRoom"
signal sceneChanged(sceneName)
@onready var animation_player = $AnimationPlayer
@onready var cam1 = $cam1
@onready var cam2 = $cam2


		 #FUNCTION#
func _process(delta):
	if animation_player.is_playing() and Input.is_action_just_pressed("interact"):
		emit_signal('sceneChanged', goToScene)
func _on_animation_player_animation_finished(anim_name):
	emit_signal('sceneChanged', goToScene)
func clean_up():
	queue_free()


#endregion
