extends Control
func _ready():
	Musicmanager.play_music("res://Audio/welcometheme.mp3")
	GameState.score = 0

func _on_suman_button_pressed() :
	$click.play_click()
	await get_tree().create_timer(0.2).timeout
	GameState.chosen_character = "suman"
	get_tree().change_scene_to_file("res://Scenes/village_scene.tscn")


func _on_kamal_button_pressed() -> void:
	$click.play_click()
	await get_tree().create_timer(0.2).timeout
	GameState.chosen_character = "kamal"
	get_tree().change_scene_to_file("res://Scenes/kamal_thread.tscn")
