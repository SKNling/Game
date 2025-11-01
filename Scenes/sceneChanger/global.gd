extends Node

var game_data : Dictionary = {
	'first_time' : true,
	'bought' : [false, false, false, false, false, false, false, false, false],
	'skin_bought' : [false, false, false, false, false, false, false, false, false],
	"เหรียญ" : 0,
	'plant_name' : ['grass', 'cactus', 'sunflower'],
	'plant_stage' : [0, 0, 0, 0, 0, 0, 0, 0, 0],
	'collect_daily_reward_status' : false,
	'login_day' : null,
	'login_streak' : 0,
	'last_watered_time' : [null, null, null, null, null, null, null, null, null],
	'needs_water' : [true, true, true, true, true, true, true, true, true],
	'plant_grow_time' : [1, 1, 1, 1, 1, 1, 1, 1, 1],
	'รดน้ำ' : 0,
	"diary" : {},
	"diary_number" : 0,
}

#func _ready():
#	for i in range(1, 10):
#		var plant = $plant + str(i)
#		if plant:
#			Global.game_data.plants.append(plant)
#	print(Global.game_data.plants)

var save_path : String = 'user://save'

func save_game_data() -> void :
	var file : FileAccess = FileAccess.open(save_path, FileAccess.WRITE_READ)
	file.store_var(game_data)
	file.close()

func load_game_data() -> bool :
	if not FileAccess.file_exists(save_path):
		return false
	var file : FileAccess = FileAccess.open(save_path, FileAccess.READ)
	game_data = file.get_var()
	file.close()
	return true

#func save_garden():
	#var plant_data = []
	#for plant in $Garden.get_children():
		#plant_data.append({
			#"state": plant.state,
			#"position": plant.position,
			#"needs_water": plant.needs_water
		#})
	#var file = FileAccess.open(save_store_path, FileAccess.WRITE_READ)
	#file.open("user://garden.save", File.WRITE)
	#file.store_var(plant_data)
	#file.close()

#func load_garden():
	#var file = FileAccess.open(save_store_path, FileAccess.READ)
	#if file.file_exists("user://garden.save"):
		#file.open("user://garden.save", File.READ)
		#var plant_data = file.get_var()
		#file.close()

		#for plant_info in plant_data:
			#var plant_instance = preload("res://scenes/Plant.tscn").instance()
			#plant_instance.position = plant_info["position"]
			#plant_instance.state = plant_info["state"]
			#plant_instance.needs_water = plant_info["needs_water"]
			#$Garden.add_child(plant_instance)
		#	plant_instance.update_appearance()
