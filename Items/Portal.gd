extends Node2D

# Group
const GAME_STATE_GROUP: String = "GameState"

# Methods
const WIN_GAME_METHOD: String = "win_game"

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		get_tree().call_group(GAME_STATE_GROUP, WIN_GAME_METHOD)
