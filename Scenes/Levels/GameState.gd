extends Node2D

var _lives: int = 3
var _coins: int = 0
var _target_number_of_coins: int = 10

# Groups
const GAME_STATE_GROUP: String = "GameState"
const GUI_GROUP: String = "GUI"

# Methods
const UPDATE_LIVES_METHOD: String = "update_lives"
const UPDATE_COINS_METHOD: String = "update_coins"

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


func end_game() -> void:
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().change_scene("res://Scenes/GameOver.tscn")