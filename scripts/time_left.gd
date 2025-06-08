extends Label

var timer := Timer.new()
var hit = false
var duration

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	duration = get_node("/root/GlobalVariables").time
	add_child(timer)
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = duration
	timer.one_shot = true
	timer.start()

func _on_timer_timeout() -> void:
	lose()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hit:
		duration = timer.time_left
		duration -= 100.0
		if duration <= 0.0:
			lose()
		timer.stop()
		timer.wait_time = duration
		hit = false
		timer.start()
	if duration > 0.0:
		get_node("/root/GlobalVariables").time = duration
	self.text = str(roundf(timer.time_left))


func lose() -> void:
	GlobalVariables.victory_text = "YOU LOST !!!"
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
