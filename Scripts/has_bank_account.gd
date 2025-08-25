extends Node

var index = 0
var lines = [
	{"speaker": "narrator", "text": "    Do you know about UPI? 
		It makes payments easy through your phone."},
	{"speaker": "character", "text": "I’ve heard of it, but I’ve never used it."},
	{"speaker": "prabha", "text": "Apps like BHIM, GPay, or PhonePe help you 
	send money directly through QR codes."},
	{"speaker": "prabha", "text": "All you need is a bank account 
	and your phone number linked to it."},
	{"speaker": "character", "text": "Really? And it’s safe?"},
	{"speaker": "prabha", "text": "Yes, as long as you don’t share your PIN 
	or scan random QR codes."},
	{"speaker": "narrator", "text": "Let’s test what you’ve learned with a short UPI safety quiz!"}
]

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()
	$prabha.show()
	$prabha/Label.hide()
	$NarrationLabel.hide()
	$StartQuiz.hide()
	$back.hide()

	CharacterAutoload.load_character()
	var pc = get_node("PlayerCharacter")
	pc.position = Vector2(320, 300)
	pc.get_node("Label").hide()
	pc.get_node("AnimationPlayer").play(GameState.chosen_character)

	show_line()

func _on_next_pressed():
	$click.play()
	index += 1

	if index >= lines.size():
		end_scene()
	else:
		show_line()

func _on_back_pressed():
	$click.play()
	if index > 0:
		index -= 1
		$StartQuiz.hide()
		$next.show()
		show_line()

func show_line():
	$NarrationLabel.hide()
	$prabha/Label.hide()
	get_node("PlayerCharacter/Label").hide()

	var entry = lines[index]
	var speaker = entry["speaker"]
	var text = entry["text"]

	match speaker:
		"narrator":
			$NarrationLabel.text = text
			$NarrationLabel.show()

		"prabha":
			$prabha/Label.text = text
			$prabha/Label.show()

		"character":
			get_node("PlayerCharacter/Label").text = text
			get_node("PlayerCharacter/Label").show()

	# Show/hide back button
	if index == 0:
		$back.hide()
	else:
		$back.show()

func end_scene():
	$NarrationLabel.hide()
	$prabha/Label.hide()
	get_node("PlayerCharacter/Label").hide()
	$next.hide()
	$back.hide()
	$StartQuiz.show()

func _on_start_quiz_pressed():
	$CorrectAnswer.play_correct()
	GameState.current_quiz = "upi"
	get_tree().change_scene_to_file("res://Scenes/QuizScene.tscn")
