extends Node

var debugNumber = 0
var firstTime = true



var savePath = "user://abcdefg.save"

func saveData():
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(debugNumber)
	file.store_var(firstTime)
	print("data saved.")
	
func loadData():
	print("starting loading data...")
	if FileAccess.file_exists(savePath):
		var file: FileAccess = FileAccess.open(savePath, FileAccess.READ)
		debugNumber = file.get_var(debugNumber)
		firstTime = file.get_var(firstTime)
		print("data loaded.")
	else:
		print("no saved data...")
		print("starting to save data...")
		saveData()
