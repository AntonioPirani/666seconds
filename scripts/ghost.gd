extends CharacterBody2D

const Fireball = preload("res://scenes/fireball.tscn")
var timer := Timer.new()
var firerate = 1.0
var lock = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.wait_time = firerate
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout() -> void:
	if GlobalVariables.fighting:
		shoot()
		timer.wait_time = firerate
		timer.start()

func shoot() -> void:
	var fireball = Fireball.instantiate()
	add_child(fireball)
	fireball.transform = $Aim.transform
	
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://assets/sounds/effects/ball.mp3")
	add_child(audio_player)
	
	audio_player.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GlobalVariables.ghost_type == "":
		match randi() % 3:
			0:
				GlobalVariables.ghost_type = "electric"
			1:
				GlobalVariables.ghost_type = "fire"
			2:
				GlobalVariables.ghost_type = "water"
		while GlobalVariables.defeated_ghosts.has(GlobalVariables.ghost_type):
			match randi() % 3:
				0:
					GlobalVariables.ghost_type = "electric"
				1:
					GlobalVariables.ghost_type = "fire"
				2:
					GlobalVariables.ghost_type = "water"
	if GlobalVariables.fighting && lock && GlobalVariables.ghost_upstairs:
		timer.start()
		lock = false
	if !GlobalVariables.fighting:
		lock = true
	$AnimatedSprite2D.animation = "idle_" + GlobalVariables.ghost_type
	$AnimatedSprite2D.play()
