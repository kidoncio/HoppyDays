extends Control

# Scenes
const TUTORIAL_SCENE: String = "res://Scenes/Levels/Tutorial.tscn"
const LEVEL1_SCENE: String = "res://Scenes/Levels/Level1.tscn"
const ABOUT_SCENE: String = "res://Scenes/Levels/About.tscn"

func _on_PlayButton_pressed():
	get_tree().change_scene(LEVEL1_SCENE)


func _on_TutorialButton_pressed():
	get_tree().change_scene(TUTORIAL_SCENE)


func _on_AboutButton_pressed():
	get_tree().change_scene(ABOUT_SCENE)
