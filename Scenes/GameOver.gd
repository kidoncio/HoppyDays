extends Control

# Scenes
const LEVEL1_SCENE: String = "res://Scenes/Levels/Level1.tscn"

func _on_RestartButton_pressed():
	get_tree().change_scene(LEVEL1_SCENE)
	pass
