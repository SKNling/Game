extends CharacterBody2D

@export var player: CharacterBody2D
@export var SPEED: int = 50
@export var CHASE_SPEED: int = 150
@export var ACCELERATION: int = 300

@onready var sprite: AnimatedSprite2D = $Slime
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO
var right_bounds: Vector2
var left_bounds: Vector2

enum States {
	STILL,
	CHASE
}

var current_state = States.STILL

func _ready():
	pass

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement(delta: float) -> void:
	if current_state == States.STILL:
		sprite.play("default")
	else:
		sprite.play("chasing_animation")
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)

	move_and_slide()

func change_direction() -> void:
	if current_state == States.STILL:
		# STILL between left_bounds and right_bounds, flipping sprite and adjusting raycast target
		if sprite.flip_h:
			# currently facing/flipped for moving right
			if self.position.x <= right_bounds.x:
				direction = Vector2(1, 0)
			else:
				# flip to moving left
				sprite.flip_h = false
				ray_cast.target_position = Vector2(-400, 0)
		else:
			# currently facing/flipped for moving left (not flipped)
			if self.position.x >= left_bounds.x:
				direction = Vector2(-1, 0)
			else:
				# flip to moving right
				sprite.flip_h = true
				ray_cast.target_position = Vector2(400, 0)
	else:
		# CHASE: follow player, but only use horizontal direction for movement/raycast orientation
		var to_player = (player.position - self.position).normalized()
		var horiz = sign(to_player.x) if to_player.x != 0 else 0
		direction = Vector2(horiz, 0)
		if direction.x == 1:
			# face/move right
			sprite.flip_h = true
			ray_cast.target_position = Vector2(400, 0)
		else:
			# face/move left (or no horizontal difference)
			sprite.flip_h = false
			ray_cast.target_position = Vector2(-400, 0)

func look_for_player():
	# If the raycast hits the player, start chasing.
	# If we don't see the player and we're currently chasing, start the "stop_chase" timer.
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	else:
		if current_state == States.CHASE:
			stop_chase()

func chase_player() -> void:
	timer.stop()
	current_state = States.CHASE

func stop_chase() -> void:
	# Only start the timer if it's not already running (time_left <= 0 means it's finished/stopped)
	if timer.time_left <= 0:
		timer.start()

func _on_timer_timeout():
	current_state = States.STILL
