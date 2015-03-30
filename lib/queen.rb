class Queen < SlidingPiece
  def move_dirs
    horizontal_dirs + vertical_dirs + diagonal_dirs
  end

  def inspect
    self.color == :white ? "♕" : "♛"
  end
end
