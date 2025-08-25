extends Node

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()
	
func _on_betterway_pressed() -> void:
	$click.play_click()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/AskBankAccount.tscn")
