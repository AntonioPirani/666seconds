extends CharacterBody2D

@export var speed = 50
var screen_size
var can_move = true
var step_size = 16
var is_auto_moving = false

@onready var textbox: CanvasLayer = $"../SceneSettingText"
@onready var marker: Marker2D = $"../Outside/BeginningPos"
@onready var gateAudio: AudioStreamPlayer = $"../Outside/AudioStreamPlayer"


func _ready() -> void:
	screen_size = get_viewport_rect().size
	start_movement_sequence()


func _process(delta: float) -> void:
	var velocity = Vector2.ZERO

	if can_move:
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1

	if velocity != Vector2.ZERO or is_auto_moving:
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "down_still"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	if can_move:
		position += velocity.normalized() * speed * delta

func start_movement_sequence() -> void:
	can_move = false
	await get_tree().create_timer(1.0).timeout
	
	textbox.show_textbox()
	textbox.queue_text("For several weeks, inexplicable phenomena have been occurring
	 in the small town of Willow Creek, striking fear into the hearts of its residents.")
	textbox.display_text()
	
	await move_in_direction(Vector2.UP, 12)
	await get_tree().create_timer(1.0).timeout

	await move_in_direction(Vector2.RIGHT, 2)
	await get_tree().create_timer(1.0).timeout

	await move_in_direction(Vector2.LEFT, 4)
	await get_tree().create_timer(1.0).timeout
	textbox.queue_text("You, Father Matthew, have decided to get to 
	the bottom of it and make your way to the abandoned Blackwood Manor, 
	where you suspect the source of the haunting lies.")
	textbox.display_text()

	await move_in_direction(Vector2.RIGHT, 2)
	await get_tree().create_timer(0.5).timeout
	
	await move_in_direction(Vector2.UP, 6)

	print("transition")
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	self.position = marker.global_position
	print("Transition done")
	await move_in_direction(Vector2.UP, 12)
	await get_tree().create_timer(0.5).timeout
	gateAudio.play()
	print("Audio play called")
	await get_tree().create_timer(1.0).timeout
	await move_in_direction(Vector2.DOWN, 1)
	

func move_in_direction(direction: Vector2, steps: int) -> void:
	is_auto_moving = true  # ← Enable animation updates in _process()

	var anim = ""
	if direction == Vector2.UP:
		anim = "up"
	elif direction == Vector2.DOWN:
		anim = "down_still"
	elif direction.x != 0:
		anim = "walk"
		$AnimatedSprite2D.flip_h = direction.x < 0

	$AnimatedSprite2D.animation = anim
	$AnimatedSprite2D.play()

	for i in steps:
		var distance_moved = 0.0
		while distance_moved < step_size:
			var delta = get_process_delta_time()
			var move_amount = direction.normalized() * speed * delta
			distance_moved += move_amount.length()
			position += move_amount
			await get_tree().process_frame

	await get_tree().create_timer(0.05).timeout

	$AnimatedSprite2D.stop()
	is_auto_moving = false  # ← Done moving
