class SteppingPiece < Piece
  def initialize(color, position, board, moved)
    super
  end

  def open_path?(position) #Dummy method since doesn't matter whether there are any moves between
    true                   #end position and current position (just "steps" over them)
  end
end
