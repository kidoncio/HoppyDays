extends Node

var configuration: Dictionary = {
	"sound": true,
	"level": 1,
	"coins": 0,
	"lives": 3,
	"coins_on_begin_of_level": 0,
	"lives_on_begin_of_level": 3
}

# Files Path
const CONFIGURATION_FILE_PATH: String = "res://Configuration/Configuration.json"

func get_configuration():
	configuration = get_from_json(CONFIGURATION_FILE_PATH)
	
	return configuration


func reset():
	configuration.level = 1
	configuration.coins = 0
	configuration.lives = 3
	configuration.coins_on_begin_of_level = 0
	configuration.lives_on_begin_of_level = 3


func get_from_json(filename: String):
	var file = File.new()
	file.open(filename, File.READ)
	
	var text: String = file.get_as_text()
	var data = parse_json(text)
	
	file.close()
	
	return data


func update_configuration_file(newConfiguration = null) -> void:
	if newConfiguration:
		configuration = newConfiguration
	
	var file = File.new()
	
	if file.open(CONFIGURATION_FILE_PATH, File.WRITE) != 0:
		print("Error opening file")
		return

	file.store_line(to_json(configuration))
	file.close()
	
	pass