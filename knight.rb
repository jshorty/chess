class Knight < SteppingPiece
  def initialize(color, position, board, moved)
    super
  end

  def move_dirs #Possible move directions (delta)
    [ [2,1],[2,-1],[-2,1],[-2,-1],
    [1,2],[1,-2],[-1,2],[-1,-2] ]
  end


  def inspect
    return "♘" if @color == :white
    return "♞" if @color == :black
  end

end
