extends Node2D

var _target_number_of_coins: int = 10

# Configuration Service
onready var _configuration_service = preload("res://Scenes/ConfigurationService.gd").new()
onready var configuration: Dictionary = _configuration_service.get_configuration()

# Groups
const GAME_STATE_GROUP: String = "GameState"
const GUI_GROUP: String = "GUI"

# Methods
const UPDATE_LIVES_METHOD: String = "update_lives"
const UPDATE_COINS_METHOD: String = "update_coins"

# Scenes
const GAME_OVER_SCENE: String = "res://Scenes/GameOver.tscn"
const VICTORY_SCENE: String = "res://Scenes/Victory.tscn"
const LEVEL_SCENE: String = "res://Scenes/Levels/Level%s.tscn"

const LEVEL1_SCENE_NAME: String = "Level1"
const TUTORIAL_SCENE_NAME: String = "Tutorial"

func _ready():
	reload_configuration()
	add_to_group(GAME_STATE_GROUP)
	update_GUI()


func update_GUI() -> void:
	get_tree().call_group(GUI_GROUP, UPDATE_LIVES_METHOD, configuration.lives)
	get_tree().call_group(GUI_GROUP, UPDATE_COINS_METHOD, configuration.coins)


func hurt() -> void:
	configuration.lives -= 1
	$Player.hurt()
	
	update_GUI()
	
	if configuration.lives < 0:
		end_game()
		
		configuration.lives = 3
	
	update_configuration_file()


func coin_up() -> void:
	configuration.coins += 1
	update_GUI()
	
	var multiple_of_coins: bool = (int(configuration.coins) % _target_number_of_coins) == 0
	
	if multiple_of_coins:
		life_up()
	
	update_configuration_file()


func life_up() -> void:
	configuration.lives += 1
	update_GUI()
	update_configuration_file()


func restart_level() -> void:
	get_tree().change_scene(LEVEL_SCENE % str(configuration.level))


func end_game():
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().change_scene(GAME_OVER_SCENE)


func win_game() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	
	var scene: String = get_tree().get_current_scene().get_name()
	
	configuration.level += 1
	configuration.coins_on_begin_of_level = configuration.coins
	
	update_configuration_file()
	
	if scene == TUTORIAL_SCENE_NAME:
		configuration.level = 1
		get_tree().change_scene(LEVEL_SCENE % str(configuration.level))
	else:
		var scene_path: String = LEVEL_SCENE % str(configuration.level)
		
		if File.new().file_exists(scene_path):
			get_tree().change_scene(scene_path)
		else:
			configuration.level = 1
			update_configuration_file()
			
			get_tree().change_scene(VICTORY_SCENE)


func update_configuration_file() -> void:
	_configuration_service.update_configuration_file(configuration)


func reload_configuration() -> void:
	var scene_name: String = get_tree().get_current_scene().get_name()
	
	configuration.coins = configuration.coins_on_begin_of_level
	configuration.lives = configuration.lives_on_begin_of_level 
	
	if scene_name == LEVEL1_SCENE_NAME:
		_configuration_service.reset()


