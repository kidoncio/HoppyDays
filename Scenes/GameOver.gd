extends Control

# Scenes
const LEVEL1_SCENE: String = "res://Scenes/Levels/Level1.tscn"
const MENU_SCENE: String = "res://Scenes/Menu.tscn"

func _on_RestartButton_pressed():
	get_tree().change_scene(LEVEL1_SCENE)
	pass


func _on_MenuButton_pressed():
	get_tree().change_scene(MENU_SCENE)
	pass
