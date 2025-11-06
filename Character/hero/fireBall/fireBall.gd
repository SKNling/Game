extends Node2D


const SPEED = 200


@export var lifetime: float = 0.4  # seconds

func _ready():
	
	# Create a one-shot SceneTreeTimer and wait for its timeout, then free this node.
	await get_tree().create_timer(lifetime).timeout
	queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * SPEED * delta
	
	
	
