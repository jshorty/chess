class Board
  attr_reader :squares

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
      king_position = @white_pieces[:king].position
      @black_pieces.values.any? {|piece| piece.moves.include?(king_position) }
    else
      king_position = @black_pieces[:king].position
      @white_pieces.values.any? {|piece| piece.moves.include?(king_position) }
    end

  end


  def place_starting_pieces
    @white_pieces = {
      king: King.new(:white, [4,7], self),
      queen: Queen.new(:white, [3,7], self),
      rook1: Rook.new(:white, [0,7], self),
      rook2: Rook.new(:white, [7,7], self),
      knight1: Knight.new(:white, [1,7], self),
      knight2: Knight.new(:white, [6,7], self),
      bishop1: Bishop.new(:white, [2,7], self),
      bishop2: Bishop.new(:white, [5,7], self)
    }

    0.upto(7) do |x|
      @white_pieces["pawn#{x+1}".to_sym] = Pawn.new(:white, [x,6], self)
    end

    @black_pieces = {
      queen: Queen.new(:black, [3,0], self),
      king: King.new(:black, [4,0], self),
      rook1: Rook.new(:black, [0,0], self),
      rook2: Rook.new(:black, [7,0], self),
      knight1: Knight.new(:black, [1,0], self),
      knight2: Knight.new(:black, [6,0], self),
      bishop1: Bishop.new(:black, [2,0], self),
      bishop2: Bishop.new(:black, [5,0], self)
    }

    0.upto(7) do |x|
      @black_pieces["pawn#{x+1}".to_sym] = Pawn.new(:black, [x,1], self)
    end

    @white_pieces.values.each do |piece|
      self[piece.position] = piece
    end

    @black_pieces.values.each do |piece|
      self[piece.position] = piece
    end

  end
end
