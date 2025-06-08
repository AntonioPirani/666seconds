extends CanvasLayer

@onready var choices_dialog: PanelContainer = $"Choices Dialog"
@onready var player: CharacterBody2D = $"../.."
@onready var label: Label = $Label

@export var dialog_offset: Vector2 = Vector2(-50, -10)
@export var label_offset: Vector2 = Vector2(-100, -30)

var current_door: Area2D = null  # Variable to store the current door being interacted with

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	choices_dialog.choices = ["Yes", "No"]
	choices_dialog.visible = false
	label.visible = false
	
	choices_dialog.SELECTED.connect(onChoiceSelected)

func _process(delta: float) -> void:
	choices_dialog.position = player.global_position + dialog_offset
	label.position = player.global_position + label_offset

# Show the dialog with the correct door text and set the current door
func show_dialog_and_label(text, door: Area2D) -> void:
	choices_dialog.visible = true
	label.text = text
	label.visible = true
	current_door = door  # Store the current door reference

# Handle the player's choice (Yes/No)
func onChoiceSelected(index: int) -> void:
	# Retrieve the selected choice based on the index
	var selected_choice = choices_dialog.choices[index]
	label.visible = false
	choices_dialog.visible = false  # Hide the dialog

	# Detect if it was "Yes" or "No"
	if selected_choice == "Yes":
		print("User selected Yes!")
		if current_door:
			current_door.enter_door()  #s Call the enter_door() of the correct door
	elif selected_choice == "No":
		print("User selected No!")
		player.can_move = true
	else:
		print("Unexpected choice:", selected_choice)
