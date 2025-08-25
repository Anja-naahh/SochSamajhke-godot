extends Control

@onready var option_btn = $OptionButton
@onready var amount_input = $AmountInput
@onready var suggestion_label = $SuggestionLabel
@onready var continue_button = $ContinueButton

func _ready():
	Musicmanager.play_music("res://Audio/main_loop.mp3")
	$AmountInput.focus_mode = Control.FOCUS_ALL
	$AmountInput.editable = true
	$AmountInput.connect("focus_entered", Callable(self, "_on_LineEdit_focus"))
	option_btn.clear()
	option_btn.add_item("I earn regularly (salary, daily wage)")      # index 0
	option_btn.add_item("I earn irregularly (small jobs, farming)")   # index 1
	option_btn.add_item("I get money occasionally (family, seasonal)")# index 2

	suggestion_label.text = ""
	continue_button.hide()

	# --- MOBILE INPUT FIXES ---
	# Force numeric keyboard on phones (Godot 4.x uses constants from DisplayServer)
	amount_input.virtual_keyboard_type = LineEdit.KEYBOARD_TYPE_NUMBER

	# Correct Godot 4 signal connection
	amount_input.focus_entered.connect(_on_input_focus)
	continue_button.pressed.connect(_on_ContinueButton_pressed)

	# (If SubmitButton exists in scene, connect it too)
	$SubmitButton.pressed.connect(_on_SubmitButton_pressed)

func _on_input_focus():
	# Godot 4.4.1 uses DisplayServer for keyboard control
	DisplayServer.virtual_keyboard_show(amount_input.text)

func _on_SubmitButton_pressed():
	$click.play()
	var selected = option_btn.get_selected_id()
	var amount = amount_input.text.to_int()

	if amount <= 0:
		suggestion_label.text = "Please enter a valid amount greater than ₹0."
		return

	var suggestion = ""

	# Categorize amount into tiers
	if amount <= 500:
		suggestion = _suggest_small(selected, amount)
	elif amount <= 2000:
		suggestion = _suggest_medium(selected, amount)
	else:
		suggestion = _suggest_large(selected, amount)

	suggestion_label.text = suggestion
	continue_button.show()

# -----------------------
# Tailored Suggestion Functions
# -----------------------
func _suggest_small(selected:int, amount:int) -> String:
	match selected:
		0:
			return "With regular income but only ₹%d, start small.\n💡 Try a Piggy Bank or SHG to build habit first." % amount
		1:
			return "Since your income is irregular and low (₹%d), keep it safe in a Piggy Bank or SHG. Flexibility matters here." % amount
		2:
			return "Earning occasionally with just ₹%d? Begin with a Piggy Bank or chit fund to stay consistent." % amount
		_:
			return "Please select a valid option."
func _suggest_medium(selected:int, amount:int) -> String:
	match selected:
		0:
			return "With steady income and ₹%d, a Savings Account or SHG is a good start for safe growth." % amount
		1:
			return "Irregular income of ₹%d? Use a Savings Account or SHG to handle ups and downs." % amount
		2:
			return "For occasional income of ₹%d, try SHG or Savings Account to build discipline." % amount
		_:
			return "Please select a valid option."
func _suggest_large(selected:int, amount:int) -> String:
	match selected:
		0:
			return "Great! With regular income and ₹%d, you can explore Recurring Deposits or SIPs for growth." % amount
		1:
			return "Irregular income but good savings of ₹%d? A Savings Account works, but also consider Gold or SHG." % amount
		2:
			return "With occasional earnings but a good amount (₹%d), try SHG and gradually move into formal options like Savings Accounts." % amount
		_:
			return "Please select a valid option."
func _on_ContinueButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/BudgetPlannerScene.tscn")
