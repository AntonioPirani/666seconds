extends Area2D

@onready var player: CharacterBody2D = $"../../../Player"
@onready var textbox: CanvasLayer = $"../../../SceneSettingText"

func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		textbox.show_textbox()
		textbox.queue_text("You open the journal and read it out aloud. 'Find out how to free the ghost inside the house. There must be some notes around', your voice echoes.")
		textbox.queue_text("You take a look at the floor map. F0: Living room, Bedroom and Toilette, Kitchen. F1: Guest room, Chill room. F2: Attic. F-1: Basement")
		textbox.display_text()
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)
