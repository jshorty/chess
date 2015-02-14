class Rook < SlidingPiece
  def move_dirs
    horizontal_dirs + vertical_dirs
  end

  def inspect
    self.color == :white ? "♖" : "♜"
  end
end
