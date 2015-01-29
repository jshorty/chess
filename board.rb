class Board
  attr_accessor :squares, :pieces

  def initialize
    @squares = Array.new(8) { Array.new(8) }
    @pieces = []
  end

  def [](coordinates)
    @squares[coordinates[1]][coordinates[0]]
  end

  def []=(coordinates, value)
    @squares[coordinates[1]][coordinates[0]] = value
  end

  def empty?(x, y)
    self[[x,y]].nil?
  end

  def enemy?(x, y, color) #opponent's piece at (x,y)?
    self[[x,y]].color != color
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
    piece_at_start = self[start]
    if piece_at_start.nil?
      raise BadMoveError.new("No piece there...")

    elsif moving_into_check?(start, end_pos)
      raise BadMoveError.new("Can't do that... moving into check.")

    elsif piece_at_start.valid_moves.include?(end_pos)
      if self[end_pos] #Capture a piece if there is one
        captured_piece = pieces.select {|piece| piece.position == end_pos}.first
        pieces.delete(captured_piece)
      end
      piece_at_start.position = end_pos #Update position of the piece (object)
      piece_at_start.moved = true #Piece has been moved at least once
      self[start] = nil
      self[end_pos] = piece_at_start #Update position on the board to include the moved piece (object)

    else
      raise BadMoveError.new("You can't move there dude.")

    end
    self
  end

  #Moves regardless of whether valid or not
  def move!(start, end_pos)
    piece_at_start = self[start]
    if piece_at_start.nil?
      raise BadMoveError.new("No piece there....")
    else
      if self[end_pos]
        captured_piece = pieces.select {|piece| piece.position == end_pos}.first
        pieces.delete(captured_piece)
      end
      piece_at_start.position = end_pos
      self[start] = nil
      self[end_pos] = piece_at_start
    end
    self
  end

  def dup
    board_copy = Board.new

    @pieces.each do |piece|
      board_copy[piece.position] = piece.dup(board_copy)
      board_copy.pieces << board_copy[piece.position]
    end

    board_copy
  end

  def moving_into_check?(start, end_pos)
    board_copy = dup.move!(start, end_pos)
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

    @pieces.each { |piece| self[piece.position] = piece }
  end

  def render
    puts
    display_board = Array.new(8) { Array.new(8) }
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

  def find_pieces(color)
    pieces.select { |piece| piece.color == color }
  end

  def find_king(color)
    find_pieces(color).find { |piece| piece.class == King }
  end
end
