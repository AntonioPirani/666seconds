extends AudioStreamPlayer

func _process(_delta: float) -> void:
	if !self.playing:
		self.play()
