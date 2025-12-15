extends Area2D

@onready var player: CharacterBody2D = $"../../../../Player"
@onready var textbox: CanvasLayer = $"../../../../SceneSettingText"
@onready var marker: Marker2D = $"../../../FirstFloor/stairsup/EntranceMarker"
@onready var audio_stream_player: AudioStreamPlayer = $"../../../../DoorSound"
@onready var node: Node2D = $"../../../../Utils"

func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("entered area for door")
		set_process(true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("move player")
		move_player()
		set_process(false)
		
func _on_body_exited(body: Node2D) -> void:
	set_process(false)

func move_player() -> void:
	audio_stream_player.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	player.global_position = marker.global_position
	node.play_only(2)
