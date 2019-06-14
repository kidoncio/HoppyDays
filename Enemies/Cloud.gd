extends Node2D

var timeout: bool = false

# Scenes
const LIGHTNING_SCENE: String = "res://Enemies/Lightning.tscn"

func _process(delta):
	if $Sprite/RayCast2D.is_colliding():
		fire()


func fire() -> void:
	if !timeout:
		$Sprite/RayCast2D.add_child(load(LIGHTNING_SCENE).instance())
		$Sprite/Timer.start()
		timeout = true

func _on_Timer_timeout():
	timeout = false
