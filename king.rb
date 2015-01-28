class King < SteppingPiece

  def initialize(color, position, board, moved)
    super
  end

  def inspect
    return "♔" if @color == :white
    return "♚" if @color == :black
  end

  def move_dirs #Possible move directions (delta)
    [ [1,1],[1,-1],[0,1],[0,-1],
    [-1,1],[1,0],[-1,-1],[-1,0] ]
  end
end
