extends CanvasLayer

# Nodes
const GAME_STATE_NODE: String = "GameState"

func update_lives(lives_left: int):
	if lives_left >= 0:
		$Control/TextureRect/VBoxContainer/HBoxContainer/LifeCount.text = str(lives_left)


func update_coins(coins: int):
	if coins >= 0:
		$Control/TextureRect/VBoxContainer/HBoxContainer/CoinCount.text = str(coins)