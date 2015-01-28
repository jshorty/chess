class Rook < SlidingPiece
  def move_dirs
    horizontal_dirs + vertical_dirs
  end

  def inspect
    return "♖" if @color == :white
    return "♜" if @color == :black
  end
end
