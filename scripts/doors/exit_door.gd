extends Area2D

@onready var label: Label = $Label
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

func _ready():
	label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		label.visible = true

func _on_body_exited(_body: Node2D) -> void:
	label.visible = false

# to add audio_stream_player_2d.play()
