class SteppingPiece < Piece
  def initialize(color, position)
    super
  end

  def all_moves
    possible_moves = []
    move_dirs.each do |move|
      x = @position[0] + move[0]
      y = @position[1] + move[1]
      possible_moves << [x,y]
    end
    possible_moves
  end
end
