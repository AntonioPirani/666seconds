extends CharacterBody2D

@export var speed = 50
var screen_size
var can_move = true
var step_size = 16

func _ready() -> void:
	screen_size = get_viewport_rect().size
	start_movement_sequence()


func _process(delta: float) -> void:
	if can_move:
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1

		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "down_still"

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()

		position += velocity * delta
		move_and_slide()

func start_movement_sequence() -> void:
	can_move = false
	await get_tree().create_timer(1.0).timeout
	
	await move_in_direction(Vector2.UP, 12)
	await get_tree().create_timer(1.0).timeout

	await move_in_direction(Vector2.RIGHT, 2)
	await get_tree().create_timer(1.0).timeout

	await move_in_direction(Vector2.LEFT, 4)
	await get_tree().create_timer(1.0).timeout

	await move_in_direction(Vector2.RIGHT, 2)
	await get_tree().create_timer(0.5).timeout
	
	await move_in_direction(Vector2.UP, 6)
	
	TransitionScreen.transition()
	await move_in_direction(Vector2.UP, 2)
	# make the player move to new section here
	can_move = true
	await TransitionScreen.on_transition_finisheds
	can_move = true

func move_in_direction(direction: Vector2, steps: int) -> void:
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

	# Short pause between steps
	await get_tree().create_timer(0.05).timeout

	$AnimatedSprite2D.stop()
