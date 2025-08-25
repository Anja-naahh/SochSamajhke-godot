extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Musicmanager.play_music("res://audio/main_loop.mp3")
	$coin.update_score()
	$Label2.hide()
	$click.show()
	$noclick.show()

func _on_click_pressed() -> void:
	$wronganswer.play_wrong()
	GameState.score-=1
	$click.hide()
	$noclick.hide()
	$Label2.text="-1 for not being aware,
	try better next time"
	$Label2.show()
	await get_tree().create_timer(2.3).timeout  
	get_tree().change_scene_to_file("res://Scenes/furtherinfo.tscn")


func _on_noclick_pressed() -> void:
	$CorrectAnswer.play_correct()
	GameState.score+=1
	$click.hide()
	$noclick.hide()
	$Label2.text="Good choice!"
	$Label2.show()
	await get_tree().create_timer(2.3).timeout  
	get_tree().change_scene_to_file("res://Scenes/furtherinfo.tscn")
