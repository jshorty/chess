class Board
  attr_accessor :squares, :pieces

  def initialize
    @squares = Array.new(8) { Array.new(8) }
    @pieces = []
  end

  def [](coords)
    return self.squares[ coords[1] ][ coords[0] ]
  end

  def []=(coords, value)
    self.squares[ coords[1] ][ coords[0] ] = value
  end

  def dup
    @pieces.each_with_object(Board.new) do |piece, board_copy|
      board_copy[piece.position] = piece.dup(board_copy)
      board_copy.pieces << board_copy[piece.position]
    end
  end

  def empty?(x, y)
    self[[x,y]].nil?
  end

  def enemy?(x, y, color)
    self[[x,y]] && (self[[x,y]].color != color)
  end

  def attacked_square?(pos, enemy_color)
    enemy_pieces = find_pieces(enemy_color)
    enemy_pieces.any? { |piece| piece.valid_moves.include?(pos) }
  end

  def can_castle?(color)
    king = find_king(color)
    valid_rooks = find_rooks(color).select { |rook| rook.can_castle?(king.position) }
    return false if (in_check?(color) || king.moved) || valid_rooks.none?
    valid_rooks.any? { |rook| safe_castle_path?(king, rook) }
  end

  def safe_castle_path?(king, rook)
    enemy_color = (king.color == :white ? :black : :white)

    if king.position[0] < rook.position[0]
      x_path = ((king.position[0] + 1)...rook.position[0])
    else
      x_path = ((rook.position[0] + 1)...king.position[0])
    end

    x_path.none? { |x| attacked_square?([x, king.position[1]], enemy_color) }
  end

  def in_check?(color)
    king_pos = find_king(color).position
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)
    find_pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  def draw?(color)
    return false if in_check?(color)
    find_pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  def move(start, end_pos)
    piece = self[start]

    if empty?(start[0], start[1])
      raise BadMoveError.new("There is no piece there!")
    elsif moving_into_check?(start, end_pos)
      raise BadMoveError.new("Cannot move into check!")
    elsif piece.valid_moves.include?(end_pos)
      move!(start, end_pos)
    elsif piece.class == King && piece.castle_moves.include?(end_pos)
      if can_castle?(piece.color)
        if end_pos[0] < start[0]
          rook = find_rooks(piece.color).find {|rook| rook.position[0] < start[0]}
          move!(start, end_pos)
          move!(rook.position, [end_pos[0] + 1, end_pos[1]])
        else
          rook = find_rooks(piece.color).find {|rook| rook.position[0] > start[0]}
          move!(start, end_pos)
          move!(rook.position, [end_pos[0] - 1, end_pos[1]])
        end
      end
    else
      raise BadMoveError.new("Illegal move! Blocked or out of range.")
    end
    self
  end

  def move!(piece_pos, end_pos)
    piece = self[piece_pos]
    capture_piece!(end_pos)
    piece.position, piece.moved = end_pos, true
    self[piece_pos], self[end_pos] = nil, piece
    self
  end

  def moving_into_check?(piece_pos, end_pos)
    board_copy = dup.move!(piece_pos, end_pos)
    board_copy.in_check?(board_copy[end_pos].color)
  end

  def place_starting_pieces
    @pieces = [
      King.new(:white, [4,7], self, false),
      Queen.new(:white, [3,7], self, false),
      Rook.new(:white, [0,7], self, false),
      Rook.new(:white, [7,7], self, false),
      Knight.new(:white, [1,7], self, false),
      Knight.new(:white, [6,7], self, false),
      Bishop.new(:white, [2,7], self, false),
      Bishop.new(:white, [5,7], self, false),
      Queen.new(:black, [3,0], self, false),
      King.new(:black, [4,0], self, false),
      Rook.new(:black, [0,0], self, false),
      Rook.new(:black, [7,0], self, false),
      Knight.new(:black, [1,0], self, false),
      Knight.new(:black, [6,0], self, false),
      Bishop.new(:black, [2,0], self, false),
      Bishop.new(:black, [5,0], self, false)
    ]

    0.upto(7) do |x|
      @pieces << Pawn.new(:white, [x,6], self, false)
      @pieces << Pawn.new(:black, [x,1], self, false)
    end

    @pieces.each {|piece| self[piece.position] = piece}
  end

  def find_pieces(color)
    pieces.select { |piece| piece.color == color }
  end

  def find_king(color)
    find_pieces(color).find { |piece| piece.class == King }
  end

  def find_rooks(color)
    find_pieces(color).select { |piece| piece.class == Rook }
  end

  def capture_piece!(pos)
    pieces.delete_if {|piece| piece.position == pos}
  end

  def render
    display_board = Board.new.squares
    is_colored = false
    row_counter = 8
    display_board.each_with_index do |row, y|
      print " #{row_counter} "
      row.each_with_index do |square, x|
        if self[[x,y]].nil?
          row[x] = "   "
        else
          row[x] = " #{self[[x,y]].inspect} "
        end
        if is_colored
          row[x] = row[x].colorize(:background => :light_green)
          is_colored = false
        else
          row[x] = row[x].colorize(:background => :light_white)
          is_colored = true
        end
        print "#{row[x]}"
      end
      print "\n"
      is_colored = !is_colored
      row_counter -= 1
    end
    puts "    A  B  C  D  E  F  G  H "
  end
end
