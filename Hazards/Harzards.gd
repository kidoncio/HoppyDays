extends Area2D

# Group
const GAME_STATE_GROUP: String = "GameState"

# Methods
const HURT_METHOD: String = "hurt"

func _on_SpikeTop_body_entered(body):
	if body.has_method(HURT_METHOD):
		get_tree().call_group(GAME_STATE_GROUP, HURT_METHOD)