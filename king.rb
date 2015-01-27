class King < SteppingPiece

  def initialize(color, position)
    super
  end

  def move_dirs #Possible move directions (delta)
    [ [1,1],[1,-1],[0,1],[0,-1],
    [-1,1],[1,0],[-1,-1],[-1,0] ]
  end


end
