extends Area2D

@onready var player: CharacterBody2D = $"../../../Player"
@onready var textbox: CanvasLayer = $"../../../SceneSettingText"
@onready var overlay_layer = $"../../../Layout/Overlay"
@onready var animation = $AnimatedSprite2D


func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && !GlobalVariables.hasShovel:
		textbox.show_textbox()
		textbox.queue_text("You found a shovel in the kitchen and decided to take it. Who left it here?")
		textbox.display_text()
		overlay_layer.set_cell(Vector2i(24, 48), -1)
		GlobalVariables.hasShovel = true
		animation.hide()
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)
