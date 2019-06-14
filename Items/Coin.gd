extends Node2D

var taken: bool = false

# Groups
const GAME_STATE_GROUP: String = "GameState"

# Methods
const COIN_UP_METHOD: String = "coin_up"

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if !taken:
			taken = true
		
			$AnimationPlayer.play("Die")
			$AudioStreamPlayer2D.play()
			get_tree().call_group(GAME_STATE_GROUP, COIN_UP_METHOD)

func die() -> void:
	queue_free()