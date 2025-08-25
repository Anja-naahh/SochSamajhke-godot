extends Control

var quiz = []
var index = 0
var score=0

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()
	quiz = QuizData.quizzes[GameState.current_quiz]
	show_question()
	$FeedbackLabel.hide()

func show_question():
	if index >= quiz.size():
		show_result()
		return

	var q = quiz[index]
	$QuestionLabel.text = q["question"]

	for i in range(quiz[index]["options"].size()):
		var btn = get_node("Option%d" % (i + 1))
		btn.text = quiz[index]["options"][i]
		btn.visible = true
		btn.disabled = false

	for j in range(quiz[index]["options"].size(), 4):
		get_node("Option%d" % (j + 1)).visible = false

	$FeedbackLabel.hide()
	$next.hide()

func check_answer(selected):
	var correct = quiz[index]["answer"]
	if selected == correct:
		score += 1
		$CorrectAnswer.play_correct()
		$FeedbackLabel.text = "Correct!"
	else:
		$wronganswer.play_wrong()
		$FeedbackLabel.text = "Incorrect."
	$FeedbackLabel.show()

	for i in range(1, 5):
		get_node("Option%d" % i).disabled = true
	$next.show()

func _on_Option1_pressed(): check_answer(0)
func _on_Option2_pressed(): check_answer(1)
func _on_Option3_pressed(): check_answer(2)
func _on_Option4_pressed(): check_answer(3)

func _on_NextButton_pressed():
	if index >= quiz.size():
		if GameState.current_quiz == "upi":
			get_tree().change_scene_to_file("res://Scenes/ScamScene.tscn")
		elif GameState.current_quiz == "scam":
			get_tree().change_scene_to_file("res://Scenes/SavingsScene.tscn")
		elif GameState.current_quiz == "cardloan":
			get_tree().change_scene_to_file("res://Scenes/complaint.tscn")
		elif GameState.current_quiz == "final":
			get_tree().change_scene_to_file("res://Scenes/thankyou.tscn")
		else:
			print("Unknown quiz type")
	else:
		index += 1
		show_question()

func show_result():
	$quiz_result.play_endquiz()
	$QuestionLabel.text = "Quiz Complete!"
	$FeedbackLabel.text = "Score: %d/%d" % [score, (quiz.size())]
	GameState.score+=score
	$coin.update_score()
	$FeedbackLabel.show()
	for i in range(1, 5):
		get_node("Option%d" % i).hide()
	$next.text = "Continue"
	$next.show()
