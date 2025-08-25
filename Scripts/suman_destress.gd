extends Node
func _ready() -> void:
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()
func _on_distrust_button_pressed():
	$click.play_click()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/DistrustPage.tscn")

func _on_saferpayment_button_pressed():
	$CorrectAnswer.play_correct()
	GameState.score += 1
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/AskBankAccount.tscn")
