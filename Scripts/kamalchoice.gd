extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()



func _on_distrust_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/DistrustPage.tscn")

func _on_bettermethod_pressed() -> void:
	$CorrectAnswer.play_correct()
	GameState.score += 1
	await get_tree().create_timer(0.7).timeout
	get_tree().change_scene_to_file("res://Scenes/AskBankAccount.tscn")
