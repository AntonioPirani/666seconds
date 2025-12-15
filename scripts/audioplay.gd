extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $"../Outside/AudioStreamPlayer" 


func play_only(index: int) -> void:
	audio_stream_player.stop()
	
	for i in get_child_count():
		var child = get_child(i)
		if child is AudioStreamPlayer:
			child.stop()
			if i == index:
				child.play()
