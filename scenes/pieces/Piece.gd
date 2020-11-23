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

func _start():
	add_to_group("pieces")

func initialize(type, owning_player):
	self.piece_type = type
	self.owning_player = owning_player
	
	if owning_player == Owner.BLACK:
		$Area2D/PawnSprite.modulate = Color(.35, .35, .35, 1)

func set_selected(selected: bool):
	$Area2D/Selection.visible = selected
