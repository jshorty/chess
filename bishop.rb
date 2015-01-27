class Bishop < SlidingPiece
  def initialize(color, position)
    super
  end

  def move_dirs
    diagonal_dirs
  end
end
