extends Node2D



#region [handling scene switching]


		 #VARIABLE#
@onready var sceneName = $".".name

var doorOpen = false
@onready var door = $door
signal sceneChanged(sceneName)




		 #FUNCTION#
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if doorOpen:
			emit_signal('sceneChanged', sceneName)
		elif doorOpen == false:
			door.frame = 2
			doorOpen = true
		else:
			print('error at door')

func clean_up():
	queue_free()


#endregion
