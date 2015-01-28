require 'byebug'

class BadMoveError < StandardError
end

class Board
  attr_accessor :squares, :pieces

  def initialize
    @squares = Array.new(8) { Array.new(8) }
    place_starting_pieces
  end

  def [](coordinates) #NEED TO USE DOUBLE BRACKETS TO PASS "X, Y"
    @squares[coordinates[1]][coordinates[0]]
  end

  def []=(coordinates, new_value) #NEED TO USE DOUBLE BRACKETS TO PASS "X, Y"
    @squares[coordinates[1]][coordinates[0]] = new_value
  end

  def in_check?(color)
    #If any of the opposite color pieces can move to king_position, then in check
    if color == :white
      king_position = @pieces.select{|piece| piece.color == :white && piece.class == King}.first.position
      @pieces.any? {|piece| piece.color == :black && piece.moves.include?(king_position) }
    else
      king_position = @pieces.select {|piece| piece.color == :black && piece.class == King}.first.position
      @pieces.any? {|piece| piece.color == :white && piece.moves.include?(king_position) }
    end
  end

  def checkmate?(color)
    #Checks if there exist any valid moves to move out of check
    return pieces.select{|piece| piece.color == color && !piece.valid_moves.empty?}.empty? if in_check?(color)
    false
  end

  def draw?(color)
    unless in_check?(color)
      return pieces.select{|piece| piece.color == color && !piece.valid_moves.empty?}.empty?
    end
    false
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
    #board_copy.squares = @squares.dup
    board_copy.pieces = []

    @squares.each_with_index do |row, i|
      #board_copy.squares[i] = row.dup

      row.each_with_index do |piece, j|
        if piece
          board_copy.squares[i][j] = piece.dup(board_copy)
          board_copy.pieces << board_copy.squares[i][j]
        else
          board_copy.squares[i][j] = nil
        end
      end
    end
    board_copy
  end

  def moving_into_check?(start, end_pos)
    updated_board_copy = dup.move!(start, end_pos)
    updated_board_copy.in_check?(updated_board_copy[end_pos].color)
  end


  def place_starting_pieces
    @pieces = []

    @white_pieces = {
      king: King.new(:white, [4,7], self, false),
      queen: Queen.new(:white, [3,7], self, false),
      rook1: Rook.new(:white, [0,7], self, false),
      rook2: Rook.new(:white, [7,7], self, false),
      knight1: Knight.new(:white, [1,7], self, false),
      knight2: Knight.new(:white, [6,7], self, false),
      bishop1: Bishop.new(:white, [2,7], self, false),
      bishop2: Bishop.new(:white, [5,7], self, false)
    }

    0.upto(7) do |x|
      @white_pieces["pawn#{x+1}".to_sym] = Pawn.new(:white, [x,6], self, false)
    end

    @black_pieces = {
      queen: Queen.new(:black, [3,0], self, false),
      king: King.new(:black, [4,0], self, false),
      rook1: Rook.new(:black, [0,0], self, false),
      rook2: Rook.new(:black, [7,0], self, false),
      knight1: Knight.new(:black, [1,0], self, false),
      knight2: Knight.new(:black, [6,0], self, false),
      bishop1: Bishop.new(:black, [2,0], self, false),
      bishop2: Bishop.new(:black, [5,0], self, false)
    }

    0.upto(7) do |x|
      @black_pieces["pawn#{x+1}".to_sym] = Pawn.new(:black, [x,1], self, false)
    end

    @white_pieces.values.each do |piece|
      self[piece.position] = piece #Put on board
      @pieces << piece
    end

    @black_pieces.values.each do |piece|
      self[piece.position] = piece
      @pieces << piece
    end

    @pieces
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
end
