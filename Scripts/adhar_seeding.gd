extends Control

var index = 0
var lines = [
	{"speaker": "narrator", "text": "Sometimes, we don't get benefits we're eligible for because
	 our bank account isn’t linked to Aadhaar."},
	{"speaker": "character", "text": "How do I link it, Akka? 
	And how do I know if it’s already linked?"},
	{"speaker": "prabha", "text": "Go to your bank branch and ask
	 them to check and link it.
	It’s free of cost."},
	{"speaker": "character", "text": "Is it risky though?"},
	{"speaker": "prabha", "text": "No, as long as you do it officially. 
	Never share your Aadhaar OTP
	 with strangers."},
	{"speaker": "narrator", "text": "Linking Aadhaar can help you receive scholarships, 
	pensions, or subsidies directly in your account."},
	{"speaker": "narrator", "text": "One last time... let’s see how much you’ve learnt."}
]

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	if has_node("coin"):
		$coin.update_score()

	$prabha.show()
	$prabha/Label.hide()
	$NarrationLabel.hide()
	$next.show()
	$back.hide()
	$NextSceneButton.hide()

	CharacterAutoload.load_character()
	var pc = get_node("PlayerCharacter")
	pc.position = Vector2(300, 200)
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
		show_line()

func show_line():
	# Hide all speakers first
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
	$NextSceneButton.show()

func _on_NextSceneButton_pressed():
	$click.play()
	await get_tree().create_timer(0.2).timeout
	GameState.current_quiz = "final"
	get_tree().change_scene_to_file("res://Scenes/QuizScene.tscn")
