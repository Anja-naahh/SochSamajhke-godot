extends Control

var index = 0
var lines = [
	{"speaker": "narrator", "text": "There are many ways to save money,
		even with a small income."},
	{"speaker": "character", "text": "Really? I only thought of hiding cash under the bed!"},
	{"speaker": "prabha", "text": "There are safer and better options. 
	Let me tell you about a few."},
	{"speaker": "prabha", "text": "For example,'saving in a bank savings account' 
	earns interest and keeps your money safe."},
	{"speaker": "character", "text": "Hmm... I’ve never opened 
	a bank account before."},
	{"speaker": "prabha", "text": "There are also 'recurring deposits', 
	where you save a small amount every month."},
	{"speaker": "narrator", "text": "We’ll recommend what’s best for you next. 
	Ready to explore your options?"}
]
func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	if has_node("coin"):
		$coin.update_score()

	# Initial setup
	$prabha.show()
	$prabha/Label.hide()
	$StartSuggestion.hide()
	$back.hide()  # Back button hidden at start

	# Load character (Kamal or Suman)
	CharacterAutoload.load_character()
	var pc = get_node("PlayerCharacter")
	pc.position = Vector2(300, 200)
	pc.get_node("Label").hide()
	pc.get_node("AnimationPlayer").play(GameState.chosen_character)

	# Show first line
	show_line()

func _on_next_pressed():
	$click.play()
	index += 1

	if index >= lines.size():
		end_scene()
		return

	show_line()

func _on_back_pressed():
	$click.play()
	if index > 0:
		index -= 1
		show_line()

func show_line():
	# Hide all
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
	$StartSuggestion.show()

func _on_start_suggestion_pressed():
	$CorrectAnswer.play_correct()
	get_tree().change_scene_to_file("res://Scenes/SavingsSuggestor.tscn")
