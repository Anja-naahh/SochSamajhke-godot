extends Control

@onready var amount_input = $AmountInput
@onready var submit_button = $SubmitButton
@onready var plan_box = $PlanButtonsBox
@onready var result_box = $ResultBox
@onready var result_label = $ResultBox/BreakdownLabel
@onready var rupee_label = $ResultBox/RupeeBreakdownLabel
@onready var tip_label = $ResultBox/TipLabel
@onready var continue_button = $ContinueButton

var total_amount = 0

func _ready():
	plan_box.hide()
	result_box.hide()
	continue_button.hide()
	$AmountInput.focus_mode = Control.FOCUS_ALL
	$AmountInput.editable = true
	$AmountInput.connect("focus_entered", Callable(self, "_on_LineEdit_focus"))

func _on_SubmitButton_pressed():
	$click.play_click()
	total_amount = amount_input.text.to_int()
	if total_amount <= 0:
		result_label.text = "Please enter a valid amount greater than ₹0."
		result_box.show()
		return
	plan_box.show()
	result_box.hide()
	continue_button.hide()

func _on_BasicBudget_pressed():
	$click.play_click()
	show_plan("Basic", 50, 30, 20, "This is a balanced approach, ideal for beginners.")

func _on_PracticalBudget_pressed():
	$click.play_click()
	show_plan("Practical", 60, 20, 20, "Good for those with high fixed monthly costs.")

func _on_SmartSaver_pressed():
	$click.play_click()
	show_plan("Smart Saver", 40, 20, 40, "Maximizes savings. Great if you're planning ahead.")

func show_plan(name, needs, wants, savings, tip):
	result_label.text = "%s Plan:\nNeeds: %d%%\nWants: %d%%\nSavings: %d%%" % [name, needs, wants, savings]
	rupee_label.text = "Breakdown:\nNeeds: ₹%d\nWants: ₹%d\nSavings: ₹%d" % [
		total_amount * needs / 100,
		total_amount * wants / 100,
		total_amount * savings / 100
	]
	tip_label.text = tip
	result_box.show()
	continue_button.show()

func _on_ContinueButton_pressed():
	$click.play()
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/cards.tscn")

func _on_amount_focus():
	if OS.has_feature("mobile"):
		self.position.y = -100  

func _on_amount_unfocus():
	if OS.has_feature("mobile"):
		self.position.y = 0
