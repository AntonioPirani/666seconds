extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()

func play_click_sound() -> void:
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://assets/sounds/effects/click.mp3")
	add_child(audio_player)
	audio_player.play()

func _on_start_button_pressed() -> void:
	play_click_sound()
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_controls_button_pressed() -> void:
	play_click_sound()
	get_tree().change_scene_to_file("res://scenes/controls.tscn")


func _on_quit_button_pressed() -> void:
	play_click_sound()
	get_tree().quit()
