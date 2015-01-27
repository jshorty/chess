class Knight < SteppingPiece
  def initialize(color, position)
    super
  end

  def move_dirs #Possible move directions (delta)
    [ [2,1],[2,-1],[-2,1],[-2,-1],
    [1,2],[1,-2],[-1,2],[-1,-2] ]
  end
  
end
