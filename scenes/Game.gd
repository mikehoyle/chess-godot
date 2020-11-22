extends Node2D

enum Players {
	WHITE,
	BLACK
}

const CELL_WIDTH = 64

# 2d array that represents the game board
var board

# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize_board()
	_update_board()

func _initialize_board():
	board = []
	for x in range(8):
		board.append([])
		for y in range(8):
			board[x].append(null)
	var pawn_scene = preload("res://scenes/pieces/Piece.tscn")
	board[0][0] = pawn_scene.instance()
	board[0][0].initialize(board[0][0].PieceType.PAWN, board[0][0].Owner.BLACK)
	add_child(board[0][0])
	board[1][0] = pawn_scene.instance()
	board[1][0].initialize(board[1][0].PieceType.PAWN, board[1][0].Owner.WHITE)
	add_child(board[1][0])

func _place_piece_at_coords(x, y):
	board[x][y].position.x = (x * CELL_WIDTH) + $ChessBoard.rect_position.x
	board[x][y].position.y = (y * CELL_WIDTH) + $ChessBoard.rect_position.y

func _update_board():
	for x in range(8):
		for y in range(8):
			if board[x][y] != null:
				_place_piece_at_coords(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
