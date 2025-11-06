extends CharacterBody2D


const SPEED = 200
const JUMP_VELOCITY = -400.0
@onready var hero = $ModleOgKnight


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x > 1:
		hero.flip_h = false
	elif velocity.x < -1:
		hero.flip_h = true

	move_and_slide()
