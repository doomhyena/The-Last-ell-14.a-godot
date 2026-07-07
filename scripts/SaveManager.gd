extends Node
# SaveManager.gd
# Autoload - mentés és betöltés kezelése

const SAVE_PATH: String = "user://save_data.cfg"

func save_game() -> void:
	var config = ConfigFile.new()
	config.set_value("progress", "completed_routes", GameManager.completed_routes)
	config.set_value("progress", "unlocked_gallery", GameManager.unlocked_gallery)
	var err = config.save(SAVE_PATH)
	if err != OK:
		push_error("SaveManager: Mentés sikertelen! Error: " + str(err))
	else:
		print("SaveManager: Mentés sikeres.")

func load_game() -> void:
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err != OK:
		print("SaveManager: Nincs mentett adat, új játék indul.")
		return
	GameManager.completed_routes = config.get_value("progress", "completed_routes", [])
	GameManager.unlocked_gallery = config.get_value("progress", "unlocked_gallery", [])
	print("SaveManager: Betöltés sikeres.")

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func delete_save() -> void:
	if has_save():
		DirAccess.remove_absolute(SAVE_PATH)
		print("SaveManager: Mentés törölve.")
