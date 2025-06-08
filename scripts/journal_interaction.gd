extends Area2D

@onready var player: CharacterBody2D = $"../../Player"
@onready var textbox: CanvasLayer = $"../../SceneSettingText"

func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		textbox.show_textbox()
		textbox.queue_text("Written in your journal is the following about the three
		children who met their tragic ends here:")
		textbox.queue_text("Tommy: Died in his room during a fire on the third floor 
		while trying to save his favorite plush toy from the flames.")
		textbox.queue_text("Sarah: Drowned in the bathtub after slipping and hitting 
		her head. She always dreamed of becoming a ballerina.")
		textbox.queue_text("Lucas: Was electrocuted in the kitchen while playing with 
		a power socket. He always dreamed of exploring the world.")
		textbox.queue_text("You place the journal back on the table.")
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)
