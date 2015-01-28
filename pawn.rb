class Pawn < Piece
  def initialize(color, position, board)
    super
  end

  #We filter out blocked squares here to contain unique pawn logic
  def move_dirs
    @color == :white ? y_new = -1 : y_new = 1 #Keep track of asymmetry in
                                              #opposing pawn pieces
    x,y = @position[0],@position[1]
    move_dirs = []

    #Can move forward one square if square is empty
    move_dirs << [0, y_new] if @board[[x, y + y_new]].nil?

    #Can move forward/diagonal one square each if capturing opposing piece
    unless @board[[x + 1, y + y_new]].nil?
      move_dirs << [1, y_new] if @board[[x + 1, y + y_new]].color != @color
    end

    unless @board[[x - 1, y + y_new]].nil?
      move_dirs << [-1, y_new] if @board[[x - 1, y + y_new]].color != @color
    end

    move_dirs
  end

  #Dummy method
  def open_path?(pos)
    true
  end

  def inspect
    return "♙" if @color == :white
    return "♟" if @color == :black
  end
end
