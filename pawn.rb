class Pawn < SlidingPiece
  #We filter out blocked squares here to contain unique pawn logic
  def move_dirs
    @color == :white ? y_new = -1 : y_new = 1 #White -> up, black -> down
    x, y = @position
    move_dirs = []

    #Can move forward one square if square is empty
    case @moved
    when false
      move_dirs << [0, y_new * 2] if @board.empty?(x, y + y_new)
    when true
      move_dirs << [0, y_new] if @board.empty?(x, y + y_new)
    end

    #Can move forward/diagonal one square each if capturing opposing piece
    unless @board.empty?(x + 1, y + y_new)
      move_dirs << [1, y_new] if @board.enemy?(x + 1, y + y_new, color)
    end

    unless @board.empty?(x - 1, y + y_new)
      move_dirs << [-1, y_new] if @board.enemy?(x - 1, y + y_new, color)
    end

    move_dirs
  end

  def inspect
    return "♙" if @color == :white
    return "♟" if @color == :black
  end
end
