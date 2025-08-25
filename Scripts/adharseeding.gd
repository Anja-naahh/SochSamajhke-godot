extends Control

var index = 0
var lines = [
	{"speaker": "character", "text": "Akka, you lost ₹4000 to a scam... 
	What did you do after that?"},
	{"speaker": "prabha", "text": "First, I called my bank's helpline 
	and blocked my card.
	 Then, I filed a complaint with the RBI’s portal."},
	{"speaker": "character", "text": "You did it all online?"},
	{"speaker": "prabha", "text": "No, I didn’t know how.
	 But the Common Service Centre 
	near our village helped me."},
	{"speaker": "prabha", "text": "Even if the money doesn’t come back,
	 we must report scams.
	 That’s how the system improves."},
	{"speaker": "narrator", "text": "If you’re scammed, act quickly.
	 Helplines, portals, and even local centres can help."}
]

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	if has_node("coin"):
		$coin.update_score()

	$prabha.show()
	$prabha/Label.hide()
	$NarrationLabel.text = lines[0]["text"]
	$NarrationLabel.show()
	$next.show()
	$nextscene.hide()

	CharacterAutoload.load_character()
	var pc = get_node("PlayerCharacter")
	pc.position = Vector2(300, 200)
	pc.get_node("Label").hide()
	pc.get_node("AnimationPlayer").play(GameState.chosen_character)

func _on_next_pressed():
	$click.play()
	index += 1

	if index >= lines.size():
		$NarrationLabel.hide()
		$prabha/Label.hide()
		if has_node("PlayerCharacter"):
			get_node("PlayerCharacter/Label").hide()
		$next.hide()
		$nextscene.show()
		return

	$NarrationLabel.hide()
	$prabha/Label.hide()
	if has_node("PlayerCharacter"):
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
			var pc = get_node("PlayerCharacter")
			pc.get_node("Label").text = text
			pc.get_node("Label").show()
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

func _on_nextscene_pressed():
	$CorrectAnswer.play_correct()
	get_tree().change_scene_to_file("res://Scenes/adhar_seeding.tscn")
