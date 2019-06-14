extends Control

# Scenes
const MENU_SCENE: String = "res://Scenes/Menu.tscn"

func _on_MenuButton_pressed():
	get_tree().change_scene(MENU_SCENE)
	pass


func _on_GitHubButton_pressed():
	OS.shell_open("https://github.com/Kidoncio/HoppyDays")
	pass
