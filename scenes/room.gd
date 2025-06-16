extends Node2D

@onready var overlay_layer = $Overlay

var player_in_area := false
var swapped := false

func replace_tile():
	if swapped:
		return  # Already swapped, do nothing
	
	var coords = Vector2i(117, 13)
	var source_id = 17
	var atlas_coords = Vector2i(1, 4)
	
	overlay_layer.set_cell(coords, source_id, atlas_coords, 0)
	swapped = true
	print("swapped tiles")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = false

func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("click") and not swapped:
		replace_tile()
