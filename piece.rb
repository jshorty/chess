class Piece
  attr_reader :moves, :color
  attr_accessor :position

  def initialize(color, position, board)
    @color = color
    @position = position #Array [X, Y]
    @board = board
  end

  def dup(board)
    Piece.new(@color, @position.dup, board) #Copy piece but referencing new board!
  end

  def all_moves
    possible_moves = []
    move_dirs.each do |move|
      x = @position[0] + move[0]
      y = @position[1] + move[1]
      possible_moves << [x,y]
    end
    possible_moves
  end

  def moves
    @moves = filter_invalid(all_moves) #Final, game-valid moves
  end

  def filter_invalid(unfiltered_moves) #Filters to all on board positions
    unfiltered_moves.select { |unfiltered_move| on_board?(unfiltered_move) && open?(unfiltered_move) && open_path?(unfiltered_move)}
  end

  def on_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def open?(pos)
    @board[pos].nil? || @board[pos].color != @color
  end
end
