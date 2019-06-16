extends Node2D

var _lives: int = 3
var _coins: int = 0
var _target_number_of_coins: int = 10
var _level: int = 1

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

func _ready():
	add_to_group(GAME_STATE_GROUP)
	update_GUI()


func update_GUI() -> void:
	get_tree().call_group(GUI_GROUP, UPDATE_LIVES_METHOD, _lives)
	get_tree().call_group(GUI_GROUP, UPDATE_COINS_METHOD, _coins)


func hurt() -> void:
	_lives -= 1
	$Player.hurt()
	
	update_GUI()
	
	if _lives < 0:
		end_game()


func coin_up() -> void:
	_coins += 1
	update_GUI()
	
	var multiple_of_coins: bool = (_coins % _target_number_of_coins) == 0
	
	if multiple_of_coins:
		life_up()


func life_up() -> void:
	_lives += 1
	update_GUI()


func restart_level() -> void:
	get_tree().reload_current_scene()


func end_game() -> void:
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().change_scene(GAME_OVER_SCENE)


func win_game() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	
	var scene: String = get_tree().get_current_scene().get_name()
	
	_level += 1
	
	if scene == "Tutorial":
		_level = 1
		get_tree().change_scene(LEVEL_SCENE % str(_level))
	else:
		var scene_path: String = LEVEL_SCENE % str(_level)
		
		if has_node(scene_path):
			get_tree().change_scene(scene_path)
		else:
			get_tree().change_scene(VICTORY_SCENE)