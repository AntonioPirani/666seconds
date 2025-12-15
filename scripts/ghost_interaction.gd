extends Area2D

@onready var player: CharacterBody2D = $"../../../Player"
@onready var textbox: CanvasLayer = $"../../../SceneSettingText"
var stop = false
@onready var ghost: AnimatedSprite2D = $"../../../Newghost/AnimatedSprite2D"
func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		set_process(true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		textbox.show_textbox()
		if GlobalVariables.hasBear and GlobalVariables.hasHat and !stop:
			textbox.queue_text("You give the ghost the teddy bear with his hat. The ghost smiles at you and disappears content.")
			textbox.queue_text("You won the game! Feel free to roam around and listen to some more music :)")
			stop = true
			ghost.hide()
		if GlobalVariables.hasBear and !stop:
			textbox.queue_text("You give the ghost the teddy bear. The ghost looks at you, as if it's missing something, and disappears with a little smile.")
			textbox.queue_text("You won the game, but could have made the ghost happier. Feel free to roam around and listen to some more music :)")
			stop = true
			ghost.hide()
		if GlobalVariables.hasHat and !stop:
			textbox.queue_text("You give the ghost the dusty hat. The ghost looks at you, as if it's missing something, and disappears sadder than before.")
			textbox.queue_text("You won the game, but could have made the ghost happier. Feel free to roam around and listen to some more music :)")
			stop = true
			ghost.hide()
		if not GlobalVariables.hasBear and not GlobalVariables.hasHat:
			textbox.queue_text("The ghost wants something from you...")
		
		textbox.display_text()
		set_process(false)

func end_scene() -> void:
	var new_scene_resource = load("res://scenes/end_screen.tscn")
	var new_scene_instance = new_scene_resource.instantiate()
	
	get_tree().current_scene.free()  # Optional: remove current scene
	get_tree().root.add_child(new_scene_instance)
	get_tree().current_scene = new_scene_instance  # Sets it as the current active scene

func _on_body_exited(body: Node2D) -> void:
	set_process(false)
