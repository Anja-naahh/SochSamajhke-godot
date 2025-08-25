extends Control

var index = 0
var lines = []
var review = ""

func _ready():
	Musicmanager.play_music("res://Audio/outro.mp3")
	if has_node("coin"):
		$coin.update_score()

	$NarrationLabel.hide()
	$next.show()
	$PlayAgain.hide()

	CharacterAutoload.load_character()
	var pc = get_node("PlayerCharacter")
	pc.position = Vector2(300, 200)
	pc.get_node("Label").hide()
	pc.get_node("AnimationPlayer").play(GameState.chosen_character)

	review = get_review()

	lines = [
		{"speaker": "character", "text": "Congratulations! You've reached the end of your journey."},
		{"speaker": "character", "text": "Your final score is: " + str(GameState.score) + " out of 14."},
		{"speaker": "character", "text": review},
		{"speaker": "character", "text": "Remember: Trust verified sources. 
		Don’t share OTPs or Aadhaar details. Stay alert and help others."},
		{"speaker": "character", "text": "The village is proud of you. So are we. "}
	]

	pc.get_node("Label").text = lines[0]["text"]
	pc.get_node("Label").show()

func get_review():
	if GameState.score >= 12:
		return " Incredible! You really understood everything. So proud of you!"
	elif GameState.score >= 8:
		return " Well done! You’ve grasped the key points — keep practicing!"
	elif GameState.score >= 4:
		return " You're getting there! A bit more care and you’ll be unstoppable."
	else:
		return "Every expert starts as a beginner. Go back, reflect, and grow!"

func _on_next_pressed():
	$click.play()
	index += 1

	if index >= lines.size():
		get_node("PlayerCharacter/Label").hide()
		$next.hide()
		$PlayAgain.show()
		return

	var pc = get_node("PlayerCharacter")
	pc.get_node("Label").text = lines[index]["text"]
	pc.get_node("Label").show()

func _on_PlayAgain_pressed():
	$CorrectAnswer.play_correct()
	get_tree().change_scene_to_file("res://Scenes/welcome.tscn")
