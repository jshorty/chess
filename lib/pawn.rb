class Pawn < SlidingPiece
  def move_dirs
    @color == :white ? y_new = -1 : y_new = 1
    x, y = @position
    move_dirs = []

    # allowed to move 2 squares on first move
    if !@moved && two_ahead.between?(0, 7) && @board.empty?(x, two_ahead)
      move_dirs << [0, y_new * 2]
    end

    # can move one square forward
    if one_ahead.between?(0, 7)
      move_dirs << [0, y_new] if @board.empty?(x, one_ahead)

      # can move forward diagonally to capture
      if @board.enemy?(x + 1, one_ahead, self.color)
        move_dirs << [1, y_new]
      end

      if @board.enemy?(x - 1, one_ahead, self.color)
        move_dirs << [-1, y_new]
      end
    end
    move_dirs
  end

  def one_ahead
    @color == :white ? y_new = -1 : y_new = 1
    @position[1] + y_new
  end

  def two_ahead
    @color == :white ? y_new = -1 : y_new = 1
    @position[1] + 2 * y_new
  end

  def promoted?
    far_row = (self.color == :white ? 0 : 7)
    return true if self.position[1] == far_row
  end

  def inspect
    self.color == :white ? "♙" : "♟"
  end
end
