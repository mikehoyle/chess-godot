extends Node2D

var dragging: bool = false
var mouse_offset: Vector2;

signal dragsignal

func _ready():
	connect("dragsignal", self, "_drag_piece")

func _drag_piece():
	dragging = !dragging
	print("drag piece ")

func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = mousepos + mouse_offset


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		var mousepos = get_viewport().get_mouse_position()
		mouse_offset = self.position - mousepos
		emit_signal("dragsignal")
