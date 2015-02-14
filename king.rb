class King < SteppingPiece
  def move_dirs
    [[1,1], [1,-1], [0,1], [0,-1],
     [-1,1], [1,0], [-1,-1], [-1,0]]
  end

  def inspect
    self.color == :white ? "♔" : "♚"
  end
end
