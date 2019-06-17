extends Control

# Configuration Service
onready var _configuration_service = preload("res://Scenes/ConfigurationService.gd").new()
onready var configuration: Dictionary;

# Scenes
const MENU_SCENE: String = "res://Scenes/Menu.tscn"
const LEVEL_SCENE: String = "res://Scenes/Levels/Level%s.tscn"

func _process(delta):
	if Input.is_action_pressed("jump") || Input.is_action_pressed("ui_accept"):
		_on_RestartButton_pressed()


func _on_RestartButton_pressed():
	configuration = _configuration_service.get_configuration()
	get_tree().change_scene(LEVEL_SCENE % str(configuration.level))
	pass


func _on_MenuButton_pressed():
	get_tree().change_scene(MENU_SCENE)
	pass