extends CanvasLayer

func update_lives(lives_left: int):
	if lives_left >= 0:
		$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)


func update_coins(coins: int):
	if coins >= 0:
		$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)


func _on_MenuButton_pressed():
	$Control/QuitDialog.show_modal(true)


func _on_QuitDialog_confirmed():
	get_tree().quit()


func _on_QuitDialog_modal_closed():
	print("BLA1")
