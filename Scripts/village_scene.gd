extends Node

var lines = [
	"This is Bhola Bhaiya, the local ration shopkeeper.",
	"Few villagers have been complaining about Bhola Bhaiya scamming them..."
]

var index = 0

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$back.hide()
	show_line()

func _on_next_button_pressed() -> void:
	$click.play_click()
	index += 1

	if index < lines.size():
		show_line()
	else:
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://Scenes/suman_arrives.tscn")

func _on_back_pressed() -> void:
	$click.play_click()
	if index > 0:
		index -= 1
		show_line()

func show_line():
	$DialogLabel.text = lines[index]
	$back.visible = index>0
