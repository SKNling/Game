extends AnimatedSprite2D

@onready var doorBreakSoundPlayer = $doorBreakSoundPlayer

func _on_frame_changed():
	doorBreakSoundPlayer.play()
