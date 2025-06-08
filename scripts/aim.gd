extends Marker2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player_position = get_parent().get_parent().get_node("Player").global_position
	var direction = player_position - self.global_position
	direction = direction.normalized()
	look_at(player_position)
