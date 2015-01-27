require_relative()

class Piece
  attr_reader :moves

  def initialize(color, position, board)
    @color = color
    @position = position #Array [X, Y]
    @board = board
  end

  def moves
    on_board_moves = filter_on_board(all_moves)
    #
    @moves = []
  end

  def filter_on_board(moves) #Filters to all on board positions
    moves.select { |move| on_board?(move) }
  end

  def on_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end
end
