class Queen < SlidingPiece
  def initialize(color, position, board, moved)
    super
  end

  def move_dirs
    horizontal_dirs + vertical_dirs + diagonal_dirs
  end

  def inspect
    return "♕" if @color == :white
    return "♛" if @color == :black
  end

end
