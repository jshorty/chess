class Rook < SlidingPiece
  def initialize(color, position)
    super
  end

  def move_dirs
    horizontal_dirs + vertical_dirs
  end
end
