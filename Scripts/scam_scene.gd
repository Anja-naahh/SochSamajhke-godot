extends Control

var line = [
	"This...is Nirmal",
	"He's celebrating with his family since he won 2 lakhs",
	"But he didn't apply to any lottery... he just received a message",
	"The message said: 'Congratulations! You've won ₹2,00,000. 
	Click this link to claim now.'",
	"Nirmal clicked the link, entered his bank details and Aadhaar...",
	"...and within minutes, ₹18,000 vanished from his account."
]

var index = 0

func _ready() -> void:
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()
	$back.visible = false
	$Label.text = line[index]

func _on_next_pressed() -> void:
	$click.play_click()
	index += 1

	if index < line.size():
		$Label.text = line[index]
		$back.visible = true

		if index == line.size() - 1:
			await get_tree().create_timer(2.3).timeout
			get_tree().change_scene_to_file("res://Scenes/choosescene.tscn")

func _on_back_pressed() -> void:
	$click.play_click()
	if index > 0:
		index -= 1
		$Label.text = line[index]
		$AnimationPlayer.stop()

	if index == 0:
		$back.visible = false
