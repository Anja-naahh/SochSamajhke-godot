extends Control

var index = 0
var lines = [
	{"speaker": "narrator", "text": "Next, let’s learn about cards and loans —
	 tools that can be helpful or harmful depending on how you use them."},
	{"speaker": "prabha", "text": "First, a debit card pulls money 
	directly from your account. If you have ₹1000 
	in your account,that’s all you can spend."},
	{"speaker": "character", "text": "Okay... so I can’t go into debt with it.
	 That feels safer."},
	{"speaker": "prabha", "text": "Right. But a credit card lets you borrow money. 
	You pay it back later — but if you delay,
	 they charge interest."},
	{"speaker": "character", "text": "So credit cards are useful, but only if you’re disciplined."},
	{"speaker": "prabha", "text": "Exactly! Now about loans,they’re
	 bigger amounts borrowed for things like 
	education, medical needs, or a home."},
	{"speaker": "prabha", "text": "Loans also charge interest.
	 Missing payments can lead to
	 penalties and stress."},
	{"speaker": "character", "text": "Many people in my village avoid 
	loans because they’re scared of 
	getting trapped."},
	{"speaker": "prabha", "text": "That’s why it’s important to 
	understand the terms and borrow wisely."},
	{"speaker": "narrator", "text": "Let’s test what you’ve learned with a quick quiz!"}
]

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()

	$prabha.show()
	$gotoquiz.hide()
	$back.hide()

	CharacterAutoload.load_character()
	var pc = get_node("PlayerCharacter")
	pc.position = Vector2(300, 200)
	pc.get_node("Label").hide()
	pc.get_node("AnimationPlayer").play(GameState.chosen_character)

	show_line()

func _on_next_pressed():
	$click.play_click()
	index += 1

	if index >= lines.size():
		end_scene()
	else:
		show_line()

func _on_back_pressed():
	$click.play()
	if index > 0:
		index -= 1
		$gotoquiz.hide()
		$next.show()
		show_line()

func show_line():
	# Hide all speakers
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
	$back.visible = index > 0

func end_scene():
	$NarrationLabel.hide()
	$prabha/Label.hide()
	get_node("PlayerCharacter/Label").hide()
	$next.hide()
	$back.hide()
	$gotoquiz.show()

func _on_go_to_quiz_pressed():
	$CorrectAnswer.play_correct()
	GameState.current_quiz = "cardloan"
	get_tree().change_scene_to_file("res://Scenes/QuizScene.tscn")
