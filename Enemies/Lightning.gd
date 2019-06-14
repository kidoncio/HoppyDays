extends Node2D

const LIGHTNING_SPEED: int = 280

# Object names
const PLAYER_OBJECT_NAME: String = "Player"

# Groups
const GAME_STATE_GROUP: String = "GameState"

# Methods
const HURT_METHOD: String = "hurt"

func _ready():
	set_as_toplevel(true)
	global_position = get_parent().global_position


func _process(delta):
	position.y += LIGHTNING_SPEED * delta
	manage_collision()


func manage_collision() -> void:
	var collider: Array = $Area2D.get_overlapping_bodies()
	
	for object in collider:
		if object.name == PLAYER_OBJECT_NAME:
			get_tree().call_group(GAME_STATE_GROUP, HURT_METHOD)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
