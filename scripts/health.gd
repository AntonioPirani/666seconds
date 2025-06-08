extends TextureProgressBar

@onready var lightning: Sprite2D = $"../../Lightning"
@onready var candle: Sprite2D = $"../../Candle"
@onready var waterBottle: Sprite2D = $"../../WaterBottle"

func _process(_delta: float) -> void:
	self.value = 3 - GlobalVariables.defeated
	if Input.is_action_just_released("click") && !GlobalVariables.ghost_upstairs && self.value > 0:
		if (is_mouse_over_sprite(lightning) && GlobalVariables.ghost_type == "electric") or (is_mouse_over_sprite(candle)&& (GlobalVariables.ghost_type == "fire")) or (is_mouse_over_sprite(waterBottle) && (GlobalVariables.ghost_type == "water")):
			GlobalVariables.defeated += 1
			GlobalVariables.defeated_ghosts.append(GlobalVariables.ghost_type)
			GlobalVariables.change_ghost = true
			GlobalVariables.ghost_type = ""
			
	if GlobalVariables.defeated == 3:
		GlobalVariables.victory_text = "YOU WON !!!"
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")

func is_mouse_over_sprite(sprite: Sprite2D) -> bool:
	# Vérifie si la souris est au-dessus du Sprite2D
	var mouse_pos = sprite.get_local_mouse_position()
	return mouse_pos.x >= 0 and mouse_pos.y >= 0 and mouse_pos.x <= sprite.texture.get_width() and mouse_pos.y <= sprite.texture.get_height()
