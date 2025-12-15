extends Node

@onready var textbox: CanvasLayer = $SceneSettingText

var timer := Timer.new()
var lock = true

func _ready() -> void:
	#add_child(timer)
	
	var layout_node = get_node("Layout")
	var player_node = get_node("Player")
	player_node.close_gate_signal.connect(layout_node.close_gate)
	#timer.connect("timeout", _on_timer_timeout)
	#timer.wait_time = 10
	#timer.one_shot = true

func _process(_delta: float) -> void:
	pass
		
