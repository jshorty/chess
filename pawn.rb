class Pawn < Piece
  def initialize(color, position)
    @color = color
    @position = position
  end

  def move_dirs
    @color == :white ? y_new = 1 : y_new = -1 #Keep track of asymmetry in
                                              #opposing pawn pieces
    x,y = @position[0],@position[1]
    move_dirs = []
    move_dirs << [0, y_new]

    #If can move diagonally, AKA capturing an opposite colored piece
    move_dirs << [1, y_new] if board[x + 1, y + y_new].color != @color
    move_dirs << [-1, y_new] if board[x - 1, y + y_new].color != @color

    move_dirs
  end
end
