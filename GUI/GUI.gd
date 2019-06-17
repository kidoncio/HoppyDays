extends CanvasLayer

# Configuration Service
onready var _configuration_service = preload("res://Scenes/ConfigurationService.gd").new()
onready var configuration: Dictionary = _configuration_service.get_configuration()

# Nodes
const GAME_STATE_NODE: String = "res://Scenes/Levels/GameState.gd"

# Groups
const GAME_STATE_GROUP: String = "GameState"

# Methods
const RESTART_LEVEL_METHOD: String = "restart_level"

func _ready():
	hide_life_feedback()
	$Control/Menu/SoundButton.pressed = configuration.sound_muted
	update_sfx(configuration.sound_muted)
	update_sound_button_text()


func update_lives(lives_left: int):
	if lives_left >= 0:
		var lifesOnFeedBack: int = int($Control/TextureRect/HBoxContainer/LifeCount.text)
		
		if lives_left != lifesOnFeedBack:
			var feedbackSignal: String = ""
			
			if lives_left > lifesOnFeedBack:
				feedbackSignal = "+"
			
			$Control/LifeFeedback/HBoxContainer/LifeFeedbackLabel.text = feedbackSignal + str(lives_left - lifesOnFeedBack)
			show_life_feedback()
		
		$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)


func update_coins(coins: int):
	if coins >= 0:
		$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)


func _on_MenuButton_pressed():
	$Control/Menu.show_modal(true)


func _on_SoundButton_toggled(button_pressed: bool) -> void:
	update_sfx(button_pressed)


func update_sfx(value: bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), value)
	update_sound_configuration(value)
	update_sound_button_text()


func update_sound_configuration(value: bool) -> void:
	configuration.sound_muted = value
	_configuration_service.update_configuration_file(configuration)


func update_sound_button_text() -> void:
	var text: String = "Mute all sounds"

	if (configuration.sound_muted):
		text = "Desmute all sounds"

	$Control/Menu/SoundButton.text = text


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_CloseMenuButton_pressed():
	$Control/QuitDialog.show_modal(true)


func _on_Menu_popup_hide():
	get_tree().paused = false


func _on_RestartLevelButton_pressed():
	get_tree().call_group(GAME_STATE_GROUP, RESTART_LEVEL_METHOD)


func _on_LifeFeedbackTimer_timeout():
	hide_life_feedback()


func show_life_feedback() -> void:
	$Control/LifeFeedback/LifeFeedbackTimer.start()
	
	if $Control/LifeFeedback/HBoxContainer/LifeFeedbackLabel.visible:
		hide_life_feedback()
		yield(get_tree().create_timer(0.3), "timeout")

	$Control/LifeFeedback/HBoxContainer/LifeFeedbackLabel.show()
	$Control/LifeFeedback/HBoxContainer/LifeFeedbackIcon.show()


func hide_life_feedback() -> void:
	$Control/LifeFeedback/HBoxContainer/LifeFeedbackLabel.hide()
	$Control/LifeFeedback/HBoxContainer/LifeFeedbackIcon.hide()
