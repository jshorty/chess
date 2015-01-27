class Bishop < SlidingPiece
  def initialize(color, position, board)
    super
  end

  def move_dirs
    diagonal_dirs
  end

  def inspect
    return "♗" if @color == :white
    return "♝" if @color == :black
  end
end
