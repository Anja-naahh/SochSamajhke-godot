extends Node
var nextsteps = [
	"Bring your Adhaar card and Phone number",
	"Ask for a 'Basic Savings Bank Deposit Account (BSBDA)' form.
	 It’s free and doesn’t require any minimum balance",
	"Make sure your mobile number is linked to the account.",
	"You’ll receive a passbook or SMS confirmation
	 once the account is created"
]
var index=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$coin.update_score()
	$nextsteps.text = nextsteps[index]
	$Done.visible = false

func _on_next_pressed() -> void:
	$click.play()
	index += 1
	if index < nextsteps.size():
		$nextsteps.text=nextsteps[index]
	else:
		$next.visible = false
		$nextsteps.text = "Now you’re ready to learn digital payments!"
		$Done.visible=true
	
func _on_done_pressed() -> void:
	$CorrectAnswer.play_correct()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/HasBankAccount.tscn")
