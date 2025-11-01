extends CanvasLayer


var scene_name : String = 'forest'
var game_data = Global.game_data
signal scene_changed(scene_name: String)

func _ready() -> void :
	Global.load_game_data()
	#print(Global.game_data.bought[0], Global.game_data.bought[1], Global.game_data.bought[2], Global.game_data.bought[3], Global.game_data.bought[4])
	wait(2)

func _on_area_2d_body_entered(body):
	var parent = body.get_parent()
	print(body)
	print(parent)
		#emit_signal('scene_changed', 'forest')




func load_game_data(new_game_data) -> void :
	game_data = new_game_data
	#print("game_data = new_game_data!")
	#print('เหรียญ_label.text has been updated!')


func wait(seconds) -> void:
	await get_tree().create_timer(seconds).timeout
