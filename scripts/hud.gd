extends Control

func _process(_delta: float) -> void:
		
	if GlobalVariables.killed_electric != null:
		if GlobalVariables.killed_electric:
			get_node("ElectricTick").visible = true
		else:
			get_node("ElectricCross").visible = true
		
	if GlobalVariables.killed_fire != null:
		if GlobalVariables.killed_fire:
			get_node("CandleTick").visible = true
		else:
			get_node("CandleCross").visible = true
		
	if GlobalVariables.killed_water != null:
		if GlobalVariables.killed_water:
			get_node("WaterTick").visible = true
		else:
			get_node("WaterCross").visible = true
