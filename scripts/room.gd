extends Node2D

@onready var overlay_layer = $Overlay
@onready var textbox = $"../SceneSettingText"

var player_in_area := false
var swapped := false
var message_shown := false
var triggered := false

func close_gate():
	print("closing gate")
	var coords = Vector2i(134, 15)
	var source_id = 15
	var atlas_coords = Vector2i(12, 3)
	overlay_layer.set_cell(coords, source_id, atlas_coords, 0)
	
	await get_tree().create_timer(0.2).timeout
	
	atlas_coords = Vector2i(12, 5)
	overlay_layer.set_cell(coords, source_id, atlas_coords, 0)

func replace_tile():
	var coords = Vector2i(117, 13)
	var source_id = 17
	var atlas_coords = Vector2i(1, 4)
	
	overlay_layer.set_cell(coords, source_id, atlas_coords, 0)
	swapped = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = true
		message_shown = false

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = false

func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("click") and not swapped:
		if not GlobalVariables.hasShovel:
			if not message_shown:
				textbox.show_textbox()
				textbox.queue_text("Seems like you need a shovel to dig here...")
				textbox.display_text()
				message_shown = true
		else:
			if !triggered:
				textbox.show_textbox()
				textbox.queue_text("You dig up a chest from beneath the ground and open it. You found a teddy bear inside it!")
				textbox.display_text()
				GlobalVariables.hasBear = true
				triggered = true
				replace_tile()
