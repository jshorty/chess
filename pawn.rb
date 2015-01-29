class Pawn < SlidingPiece
  def move_dirs
    @color == :white ? y_new = -1 : y_new = 1
    x, y = @position
    move_dirs = []

    #Forward moves, 2 squares on first move
    case @moved
    when false
      move_dirs << [0, y_new * 2] if @board.empty?(x, y + y_new)
      move_dirs << [0, y_new] if @board.empty?(x, y + y_new)
    when true
      move_dirs << [0, y_new] if @board.empty?(x, y + y_new)
    end

    #Diagonal capturing moves
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
