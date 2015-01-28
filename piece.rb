class Piece
  attr_reader :color
  attr_accessor :position, :moved

  def initialize(color, position, board, moved)
    @color = color
    @position = position #Array [X, Y]
    @board = board
    @moved = false
  end

  def dup(board)
    self.class.new(@color, @position.dup, board, @moved) #Copy piece but referencing new board!
  end

  def all_moves #Position added to deltas
    possible_moves = []
    move_dirs.each do |move|
      x = @position[0] + move[0]
      y = @position[1] + move[1]
      possible_moves << [x,y]
    end
    possible_moves
  end

  def moves #Unblocked moves reachable by a piece
    all_moves.select do |move|
      on_board?(move) && can_stop_here?(move) && open_path?(move)
    end
  end

  def valid_moves #Moves that don't leave you in check
    moves.select { |move| !@board.moving_into_check?(@position, move)}
  end

  def on_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def can_stop_here?(pos)
    x, y = pos
    @board.empty?(x, y) || @board.enemy?(x, y, color)
  end
end
