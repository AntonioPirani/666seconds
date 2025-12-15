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
		textbox.queue_text("You look at the broken clock. A note hanging from the pendulum reads 'I wonder where I left my attic key, I last had it when I went to the toilet.'")
		textbox.display_text()
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)
