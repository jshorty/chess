class Rook < SlidingPiece
  def initialize(color, position, board)
    super
  end

  def move_dirs
    horizontal_dirs + vertical_dirs
  end

  def inspect
    return "♖" if @color == :white
    return "♜" if @color == :black
  end
end
