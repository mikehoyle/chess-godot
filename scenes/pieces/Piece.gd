extends Node2D

var dragging: bool = false
var mouse_offset: Vector2;

enum PieceType {
	PAWN,
	ROOK,
	BISHOP,
	KNIGHT,
	QUEEN,
	KING
}

enum Owner {
	WHITE,
	BLACK
}

var piece_type
var owning_player

func initialize(type, owning_player):
	self.piece_type = type
	self.owning_player = owning_player
	
	if owning_player == Owner.BLACK:
		$Area2D/PawnSprite.modulate = Color(.3, .3, .3, 1)
	

func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = mousepos + mouse_offset


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		var mousepos = get_viewport().get_mouse_position()
		mouse_offset = self.position - mousepos
		dragging = !dragging
