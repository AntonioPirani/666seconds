extends Area2D

@onready var label: Label = $Label
@onready var marker: Marker2D = $"../../RoomRight/Position1"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"

func _ready():
	label.visible = false
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		label.visible = true
		set_process(true)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		move_player()
		set_process(false)

func move_player() -> void:
	if marker:
		var player = get_node("../../../Player")
		if player:
			player.can_move = false
			audio_stream_player_2d.play()
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			player.can_move = true
			player.global_position = marker.global_position

func _on_body_exited(_body: Node2D) -> void:
	label.visible = false
	set_process(false)
