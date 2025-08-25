extends Node

var conversation = [
	{"name": "Suman", "text": "Here’s ₹350."},
	{"name": "Bhola", "text": "You gave ₹330. Here's ₹10 back."},
	{"name": "Suman", "text": "No, I gave ₹350..."},
	{"name": "Bhola", "text": "Arrey, didi, don’t argue. I counted properly."},
]

var index = 0

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	_clear_all_bubbles()
	$back.visible = false
	_show_dialog(conversation[index])

func _clear_all_bubbles():
	$SpeechBubbles/BubbleSuman.visible = false
	$SpeechBubbles/BubbleBhola.visible = false

func _show_dialog(entry):
	_clear_all_bubbles()

	match entry.name:
		"Suman":
			$SpeechBubbles/BubbleSuman.visible = true
			$SpeechBubbles/BubbleSuman/TextSuman.text = entry.text
		"Bhola":
			$SpeechBubbles/BubbleBhola.visible = true
			$SpeechBubbles/BubbleBhola/TextBhola.text = entry.text
		"Narrator":
			$SpeechBubbles/BubbleSuman.visible = true
			$SpeechBubbles/BubbleSuman/TextSuman.text = entry.text

	# Handle back button visibility
	$back.visible = index > 0

func _on_next_button_pressed() -> void:
	$click.play_click()
	index += 1

	if index < conversation.size():
		_show_dialog(conversation[index])
	else:
		_clear_all_bubbles()
		$back.hide()
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://Scenes/suman_destress.tscn")

func _on_back_pressed() -> void:
	$click.play_click()
	if index > 0:
		index -= 1
		_show_dialog(conversation[index])
