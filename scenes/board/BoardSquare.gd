extends Control

# Determines board square color
export var is_white: bool = true

func _ready():
	if !is_white:
		$FillColor.color = Color(0.93, 0.87, 0.54, 1)
