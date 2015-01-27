class Piece
  attr_reader :moves

  def initialize(color, position, board)
    @color = color
    @position = position #Array [X, Y]
    @board = board
  end

  def all_moves
    possible_moves = []
    move_dirs.each do |move|
      x = @position[0] + move[0]
      y = @position[1] + move[1]
      possible_moves << [x,y]
    end
    possible_moves
  end

  def moves
    @moves = filter_invalid(all_moves) #Final, game-valid moves
  end

  def filter_invalid(unfiltered_moves) #Filters to all on board positions
    unfiltered_moves.select { |unfiltered_move| on_board?(move) && open?(move) && open_path?(move)}
  end

  def on_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def open?(x,y)
    board[x,y].nil? || board[x,y].color != @color
  end
end
