extends CharacterBody2D

@export var speed := 50
var screen_size
var can_move := true
var step_size := 16
var is_auto_moving := false

@onready var textbox: CanvasLayer = $"../SceneSettingText"
@onready var marker: Marker2D = $"../Outside/BeginningPos"
@onready var gateAudio: AudioStreamPlayer = $"../Outside/AudioStreamPlayer"
@export var layout_node: Node
@onready var background: AudioStreamPlayer = $"../Outside/AudioStreamPlayer2"

signal close_gate_signal

func _ready() -> void:
	screen_size = get_viewport_rect().size
	start_movement_sequence()

func _physics_process(delta: float) -> void:
	if can_move or is_auto_moving:
		move_and_slide()

func _process(delta: float) -> void:
	var input_velocity = Vector2.ZERO

	if can_move and not is_auto_moving:
		if Input.is_action_pressed("move_right"):
			input_velocity.x += 1
		if Input.is_action_pressed("move_left"):
			input_velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			input_velocity.y += 1
		if Input.is_action_pressed("move_up"):
			input_velocity.y -= 1

		velocity = input_velocity.normalized() * speed

	if not is_auto_moving:
		if input_velocity != Vector2.ZERO:
			if input_velocity.x != 0:
				$AnimatedSprite2D.animation = "walk"
				$AnimatedSprite2D.flip_h = input_velocity.x < 0
			elif input_velocity.y < 0:
				$AnimatedSprite2D.animation = "up"
			elif input_velocity.y > 0:
				$AnimatedSprite2D.animation = "down_still"
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()

func start_movement_sequence() -> void:
	background.play()
	can_move = false
	await get_tree().create_timer(1.0).timeout

	textbox.show_textbox()
	textbox.queue_text("For several weeks, inexplicable phenomena have been occurring in the small town of Willow Creek, striking fear into the hearts of its residents.")
	textbox.display_text()

	await move_in_direction(Vector2.UP, 12)
	await get_tree().create_timer(1.0).timeout

	await move_in_direction(Vector2.RIGHT, 2)
	await get_tree().create_timer(1.0).timeout

	await move_in_direction(Vector2.LEFT, 4)
	await get_tree().create_timer(1.0).timeout
	textbox.queue_text("You, Father Matthew, have decided to get to the bottom of it and make your way to the abandoned Blackwood Manor.")
	textbox.display_text()

	await move_in_direction(Vector2.RIGHT, 2)
	await get_tree().create_timer(0.5).timeout

	await move_in_direction(Vector2.UP, 6)

	print("transition")
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	global_position = marker.global_position
	print("Transition done")
	await move_in_direction(Vector2.UP, 14)
	textbox.force_close_textbox()

	await get_tree().create_timer(0.5).timeout
	emit_signal("close_gate_signal")
	print("signal emitted")
	gateAudio.play()

	await get_tree().create_timer(0.2).timeout
	await move_in_direction(Vector2.DOWN, 1)

	can_move = true

func move_in_direction(direction: Vector2, steps: int) -> void:
	is_auto_moving = true

	var anim := ""
	if direction == Vector2.UP:
		anim = "up"
	elif direction == Vector2.DOWN:
		anim = "down_still"
	elif direction.x != 0:
		anim = "walk"
		$AnimatedSprite2D.flip_h = direction.x < 0

	$AnimatedSprite2D.animation = anim
	$AnimatedSprite2D.play()

	var total_distance := step_size * steps
	var moved_distance := 0.0
	var start_position := global_position

	velocity = direction.normalized() * speed

	while moved_distance < total_distance:
		await get_tree().physics_frame
		moved_distance = global_position.distance_to(start_position)

	velocity = Vector2.ZERO
	$AnimatedSprite2D.stop()
	is_auto_moving = false
