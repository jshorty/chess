class Knight < SteppingPiece
  def move_dirs
    [[2,1], [2,-1], [-2,1], [-2,-1],
     [1,2], [1,-2], [-1,2], [-1,-2]]
  end

  def inspect
    self.color == :white ? "♘" : "♞"
  end
end
