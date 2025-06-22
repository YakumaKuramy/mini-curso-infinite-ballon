extends Node

const SAVE_PATH: String = "user://game.0.0.1.sav"

var BASE_DATA : Dictionary = {
	"score": 0,
	"best_score": 0,
	"sfx_volume" : -30,
	"bgm_volume" : -30,
}

var save_data = BASE_DATA

func _ready() -> void:
	_load_or_create_file()


func _load_or_create_file() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		save_data = file.get_var()
		#print("GAME LOADED SUCCESSFULLY")
		file.close()
	else:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_var(BASE_DATA)
		#print("ERROR IN LOADING FILE, CREATING FILE")
		file.close()


func save_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(save_data)
	#print("SUCCESSFULLY SAVED GAME")
	file.close()
