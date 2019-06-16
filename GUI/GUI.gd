extends CanvasLayer

var configuration: Dictionary = {
	"sound": true
}

# Files Path
const CONFIGURATION_FILE_PATH: String = "res://Configuration/Configuration.json"

# Groups
const GAME_STATE_GROUP: String = "GameState"

# Methods
const RESTART_LEVEL_METHOD: String = "restart_level"

func _ready():
	var configuration = get_from_json(CONFIGURATION_FILE_PATH)
	$Control/Menu/SoundButton.pressed = configuration.sound
	update_sfx(configuration.sound)
	update_sound_button_text()


func update_lives(lives_left: int):
	if lives_left >= 0:
		$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)


func update_coins(coins: int):
	if coins >= 0:
		$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)


func _on_MenuButton_pressed():
	$Control/Menu.show_modal(true)


func _on_SoundButton_toggled(button_pressed: bool) -> void:
	print(button_pressed, "BUTTON PRESSED")
	update_sfx(button_pressed)


func update_sfx(value: bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), value)
	update_sound_configuration(value)
	update_sound_button_text()


func update_sound_configuration(value: bool) -> void:
	configuration.sound = value
	update_configuration_file()


func update_sound_button_text() -> void:
	var text: String = "Mute all sounds"

	if (configuration.sound):
		text = "Desmute all sounds"

	$Control/Menu/SoundButton.text = text


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_CloseMenuButton_pressed():
	$Control/QuitDialog.show_modal(true)


func _on_Menu_popup_hide():
	get_tree().paused = false


func update_configuration_file() -> void:
	var file = File.new()

	if file.open(CONFIGURATION_FILE_PATH, File.WRITE) != 0:
		print("Error opening file")
		return

	file.store_line(to_json(configuration))
	file.close()
	pass


func get_from_json(filename: String) -> Array:
	var file = File.new()
	file.open(filename, File.READ)
	
	var text: String = file.get_as_text()
	var data: Array = parse_json(text)
	
	file.close()
	
	return data

func _on_RestartLevelButton_pressed():
	get_tree().call_group(GAME_STATE_GROUP, RESTART_LEVEL_METHOD)
