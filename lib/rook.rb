class Rook < SlidingPiece
  def move_dirs
    horizontal_dirs + vertical_dirs
  end

  def inspect
    self.color == :white ? "♖" : "♜"
  end

  def can_castle?(king_pos)
    self.open_path_to_position?(king_pos) && !self.moved
  end
end
