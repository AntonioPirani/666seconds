extends Area2D

@onready var player: CharacterBody2D = $"../../../Player"
@onready var textbox: CanvasLayer = $"../../../SceneSettingText"

var counter = 0

func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		textbox.show_textbox()
		if counter <2:
			textbox.queue_text("You flush the toilet.")
		else:
			if counter == 2:
				textbox.queue_text("The water overflows on the carpet. A wet and rusty key drops on the ground. You pick it up, may need it later.")
				GlobalVariables.hasKey = true
			else:
				textbox.queue_text("The toilet stopped working.")

		textbox.display_text()
		counter=counter+1
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)
