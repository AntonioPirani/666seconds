extends Area2D

@onready var player: CharacterBody2D = $"../../../Player"
@onready var textbox: CanvasLayer = $"../../../SceneSettingText"
@onready var marker: Marker2D = $"../../../Inside/GroundFloor/Entrance/EntranceMarker"
@onready var audio_stream_player_2d: AudioStreamPlayer = $"../../../Utils/DoorSound"



func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		move_player()
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)

func move_player() -> void:
	audio_stream_player_2d.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	player.global_position = marker.global_position
