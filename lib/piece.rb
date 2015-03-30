class Piece
  attr_reader :color
  attr_accessor :position, :moved

  def initialize(color, position, board, moved)
    @color = color
    @position = position
    @board = board
    @moved = false
  end

  def dup(board)
    self.class.new(@color, @position.dup, board, @moved)
  end

  def valid_moves
    moves.reject {|move| @board.moving_into_check?(@position, move)}
  end

  def moves
    all_moves.select do |move|
      on_board?(move) &&
      can_stop_here?(move) &&
      open_path_to_position?(move)
    end
  end

  def all_moves
    move_dirs.each_with_object([]) do |move, possible_moves|
      x, y = (@position[0] + move[0]), (@position[1] + move[1])
      possible_moves << [x,y]
    end
  end

  def on_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def can_stop_here?(pos)
    x, y = pos
    @board.empty?(x, y) || @board.enemy?(x, y, color)
  end

end
