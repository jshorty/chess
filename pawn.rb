class Pawn < SlidingPiece
  def move_dirs
    @color == :white ? y_new = -1 : y_new = 1
    x, y = @position
    move_dirs = []

    # allowed to move 2 squares on first move
    if !@moved && @board.empty?(x, y + y_new * 2)
      move_dirs << [0, y_new * 2]
    end

    # can move one square forward
    move_dirs << [0, y_new] if @board.empty?(x, y + y_new)

    # can move forward diagonally to capture
    if @board.enemy?(x + 1, y + y_new, self.color)
      move_dirs << [1, y_new]
    end

    if @board.enemy?(x - 1, y + y_new, self.color)
      move_dirs << [-1, y_new]
    end

    move_dirs
  end

  def inspect
    self.color == :white ? "♙" : "♟"
  end
end
