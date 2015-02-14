class Bishop < SlidingPiece

  def move_dirs
    diagonal_dirs
  end

  def inspect
    @color == white ? "♗" : "♝"
  end

end
