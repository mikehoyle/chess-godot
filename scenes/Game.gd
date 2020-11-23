extends Node2D

enum Players {
	WHITE,
	BLACK
}

const CELL_WIDTH = 64

# 2d array that represents the game board
var board
var board_offset_x
var board_offset_y

var currently_selected_piece = null

# Called when the node enters the scene tree for the first time.
func _ready():
	board_offset_x = $ChessBoard.rect_position.x
	board_offset_y = $ChessBoard.rect_position.y
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

func _update_board():
	for x in range(8):
		for y in range(8):
			if board[x][y] != null:
				board[x][y].position = _coords_from_indices(Vector2(x, y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Translates viewport coords to board matrix indices
# null if out of range.
func _indices_from_coords(mouse_coords: Vector2):
	var x_index = floor((mouse_coords.x - board_offset_x) / CELL_WIDTH)
	var y_index = floor((mouse_coords.y - board_offset_y) / CELL_WIDTH)
	if x_index < 0 or x_index > 7 or y_index < 0 or y_index > 7:
		return null
	return Vector2(x_index, y_index)

# Translates board matrix indices to game coords
func _coords_from_indices(indices: Vector2) -> Vector2:
	var coords = Vector2()
	coords.x = (indices.x * CELL_WIDTH) + board_offset_x
	coords.y = (indices.y * CELL_WIDTH) + board_offset_y
	return coords

func _on_ChessBoard_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT \
			and event.pressed:
		var indices = _indices_from_coords(get_viewport().get_mouse_position())
		if indices != null:
			if self.currently_selected_piece and !board[indices.x][indices.y]:
				var old_position = _indices_from_coords(\
					self.currently_selected_piece.position)
				self.currently_selected_piece.position = \
					_coords_from_indices(indices)
				board[indices.x][indices.y] = currently_selected_piece
				board[old_position.x][old_position.y] = null
				currently_selected_piece.set_selected(false)
				currently_selected_piece = null
				return
				
			if board[indices.x][indices.y]:
				self.currently_selected_piece = board[indices.x][indices.y]
				for piece in get_tree().get_nodes_in_group("pieces"):
					piece.set_selected(false)
				self.currently_selected_piece.set_selected(true)
