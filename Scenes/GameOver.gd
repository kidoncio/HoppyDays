extends Control

# Configuration Service
onready var _configuration_service = preload("res://Scenes/ConfigurationService.gd").new()
onready var configuration: Dictionary = _configuration_service.get_configuration()

# Groups
const GAME_STATE_GROUP: String = "GameState"

# Scenes
const MENU_SCENE: String = "res://Scenes/Menu.tscn"
const LEVEL_SCENE: String = "res://Scenes/Levels/Level%s.tscn"

# Methods
const RESTART_LEVEL_METHOD: String = "restart_level"

func _on_RestartButton_pressed():
	get_tree().change_scene(LEVEL_SCENE % str(configuration.level))
	pass


func _on_MenuButton_pressed():
	get_tree().change_scene(MENU_SCENE)
	pass