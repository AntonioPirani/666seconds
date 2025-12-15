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
		textbox.queue_text("You can't see your reflection on the mirror. Maybe you are the ghost?")
		textbox.display_text()
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)
