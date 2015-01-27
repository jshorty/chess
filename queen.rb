class Queen < SlidingPiece
  def initialize(color, position)
    super
  end

  def move_dirs
    horizonal_dirs + vertical_dirs + diagonal_dirs
  end
end
