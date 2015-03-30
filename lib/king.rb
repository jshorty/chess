class King < SteppingPiece
  def move_dirs
    [[1,1], [1,-1], [0,1], [0,-1],
     [-1,1], [1,0], [-1,-1], [-1,0]]
  end

  def inspect
    self.color == :white ? "♔" : "♚"
  end

  def castle_moves
    y = (self.color == :white ? 7 : 0)
    [[2, y], [6, y]]
  end
end
