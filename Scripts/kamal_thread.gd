extends Node

var index = 0
var lines = [
	{"speaker": "narrator", "text": "Chotelal sells seeds at a stall..
	but something about him is a little off "},
	{"speaker": "kamal_entry", "text": "Kamal arrives, curious about the seeds."},
	{"speaker": "chotelal", "text": "Fresh seeds! Half now.. half after harvest!"},
	{"speaker": "kamal", "text": "Hmm... looks fine. How much?"},
	{"speaker": "chotelal", "text": "Just ₹200. Pay in cash"},
	{"speaker": "narrator", "text": "Kamal pays and leaves."},
	{"speaker": "narrator", "text": "— The after harvest day —"},
	{"speaker": "narrator", "text": "Kamal returns to the stall..."},
	{"speaker": "kamal", "text": "Wait... where is he?"},
	{"speaker": "kamal", "text": "The seeds didn’t even sprout… did I just get scammed?"}
]
func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$Scammer.show()
	$kamal.hide()
	$FadeRect.hide()
	$back.hide()

	show_line()

func _on_next_pressed():
	$click.play()
	index += 1

	if index >= lines.size():
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://Scenes/kamalchoice.tscn")
		return

	show_line()

func _on_back_pressed():
	$click.play()
	if index > 0:
		index -= 1
		show_line()

func show_line():
	# Hide all
	$Scammer/Label.hide()
	$kamal/Label.hide()
	$NarrationLabel.hide()
	$FadeRect.hide()

	var entry = lines[index]
	var speaker = entry["speaker"]
	var text = entry["text"]

	match speaker:
		"narrator":
			$NarrationLabel.text = text
			$NarrationLabel.show()

		"kamal_entry":
			$kamal.show()
			$kamal/AnimationPlayer.play("Kamal")
			$NarrationLabel.text = text
			$NarrationLabel.show()

		"kamal":
			$kamal/Label.text = text
			$kamal/Label.show()

		"chotelal":
			$Scammer/Label.text = text
			$Scammer/Label.show()

	# Scene transitions based on line index
	if index == 1:
		$Scammer.show()
	elif index == 6:
		$FadeRect.show()
		$Scammer.hide()
		$kamal.hide()
	elif index == 7:
		$FadeRect.hide()
		$kamal.show()
		$kamal/AnimationPlayer.play("Kamal")

	# Back button visibility
	$back.visible = index > 0
