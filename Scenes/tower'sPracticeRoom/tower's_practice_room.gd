extends Node2D



#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName = $".".name
@export var goToScene = "tower'sRoom1"
@export var door : AnimatedSprite2D
signal sceneChanged(sceneName)
var doorOpen = false


		 #FUNCTION#
func _process(delta):
	if door.frame_changed:
		doorOpen = true
	
	if Input.is_action_just_pressed("interact") and doorOpen:
		emit_signal('sceneChanged', goToScene)







func clean_up():
	queue_free()


#endregion
