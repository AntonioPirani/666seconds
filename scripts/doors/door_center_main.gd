extends Area2D

@onready var label: Label = $Label
@onready var marker: Marker2D = $"../../RoomCenterSmall/Position2"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var canvas_layer: CanvasLayer = $"../../../Player/Camera2D/CanvasLayer"
@onready var player: CharacterBody2D = $"../../../Player"
@onready var textbox: CanvasLayer = $"../../../SceneSettingText"

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
			label.visible = false
			canvas_layer.show_dialog_and_label("You are about to enter the kitchen, are you sure?", self)

func _on_body_exited(_body: Node2D) -> void:
	label.visible = false
	set_process(false)
	
func enter_door() -> void:
	# Play the audio, transition, and move the player only when "Yes" is selected
	audio_stream_player_2d.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	player.can_move = true
	player.global_position = marker.global_position
	
	if GlobalVariables.ghost_upstairs:
		# do nothing
		print("the ghost is upstairs")
	else:
	
		if GlobalVariables.ghost_type == "electric":
			textbox.show_textbox()
			textbox.queue_text("You have found the ghost!") 
			textbox.queue_text("Give it the item it seeks and release it into eternal sleep!") 
		else:
			player.move_and_stop()
			textbox.show_textbox()
			textbox.queue_text("Even after thoroughly searching the room, 
			you cannot find anybody here.") 
			textbox.queue_text("You decided to return to the corridor
			and to take a look at your notes again.")
