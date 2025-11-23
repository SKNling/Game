extends CharacterBody2D


const SPEED : int = 200
const JUMP_VELOCITY : float = -400.0
@onready var sprite : AnimatedSprite2D = $ModleOgKnight
@onready var player : CharacterBody2D = $"."

enum states {IDLE,WALK,JUMP,FALL,ATTACK,DEAD}
var currentState = states.IDLE




func _process(delta):
	jumpSoundPlay()

#region [JumpMechanics]
@onready var jumpSoundPlayer : AudioStreamPlayer = $jumpSoundPlayer
var jumped : bool = false
func jumpSoundPlay():
	if currentState == states.JUMP and jumped == false:
		jumped = true
		jumpSoundPlayer.play()
	if currentState != states.JUMP:
		jumped = false
#endregion

#region [AttackSection]
@onready var attackComponent : Area2D = $AttackComponent
@export var ATKCD: float
@onready var swordHitSoundPlayer : AudioStreamPlayer = $swordHitSoundPlayer
func hit():
	attackComponent.monitorable = true
	playHitSound()
func endOfHit():
	attackComponent.monitorable = false
func playHitSound():
	randomize()
	swordHitSoundPlayer.pitch_scale = randf_range(0.8,1.2)
	swordHitSoundPlayer.play()
#endregion

#region [BasicMovement]
@onready var attackArea : CollisionShape2D = $AttackComponent/CollisionShape2D

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	handleAnimation(delta)



func handle_gravity(delta: float) -> void:
	var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement(delta: float) -> void:


	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


		
		
func handleAnimation(delta: float) -> void:
	
	if Input.is_action_just_pressed("shoot") and currentState != states.ATTACK:
		currentState = states.ATTACK
		sprite.play("ATTACK")
		await get_tree().create_timer(ATKCD).timeout
		hit()
		await sprite.animation_finished
		endOfHit()
		currentState = states.IDLE
	elif currentState != states.ATTACK:
		if currentState == states.IDLE:
			sprite.play("IDLE")
		elif currentState == states.WALK:
			sprite.play("WALK")
		elif currentState == states.JUMP:
			sprite.play("JUMP")
		elif currentState == states.DEAD:
			sprite.play("DEAD")
		#elif currentState == states.ATTACK:
			
			
			
		if velocity.y < 0:
			currentState = states.JUMP
		elif velocity.y > 0:
			currentState = states.FALL


		if velocity.x > 1:
			sprite.flip_h = false
			attackArea.position.x = 42
			if velocity.y == 0:
				currentState = states.WALK
		elif velocity.x < -1:
			attackArea.position.x = -42
			sprite.flip_h = true
			if velocity.y == 0:
				currentState = states.WALK
			
		if velocity.x == 0 and velocity.y == 0:
			currentState = states.IDLE
#endregion
