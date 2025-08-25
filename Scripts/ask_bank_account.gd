extends Node

var lines = [
	"This is Prabha Akka — the heart of the village's self-help group.",
	"She’s smart, respected, and always ready to help someone in need.",
	"She heard what happened and knew she had to step in.",
	"Now, she has something important to tell you..."
]

var index = 0

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()
	show_line()
	$yes.visible = false
	$no.visible = false

func _on_next_pressed() -> void:
	$click.play()
	index += 1
	if index < lines.size():
		show_line()
	else:
		$next.visible = false
		$back.visible = false
		$prabhaintro.text = "Do you have a bank account?"
		$yes.visible = true
		$no.visible = true

func _on_back_pressed() -> void:
	$click.play()
	if index > 0:
		index -= 1
		$yes.visible = false
		$no.visible = false
		$next.visible = true
		show_line()

func show_line():
	$prabhaintro.text = lines[index]

	# Show/hide back button
	if index == 0:
		$back.visible = false
	else:
		$back.visible = true
func _on_yes_pressed() -> void:
	$click.play_click()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/HasBankAccount.tscn")

func _on_no_pressed() -> void:
	$click.play_click()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/openbankaccount.tscn")
