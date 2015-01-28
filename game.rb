class BadMoveError < StandardError
end

class Game
  def initialize
      @board = Board.new
      @white = HumanPlayer.new(:white)
      @black = HumanPlayer.new(:black)
  end

  def play
    until @board.checkmate?(:white)
      turn(@white)
      break if @board.checkmate?(:black)
      turn(@black)
    end
  end

  def turn(player)
    begin
      @board.render
      puts "#{player.color.to_s.capitalize}, it is your turn!"
      move_from = to_coord(player.play_turn(:from))
      move_to = to_coord(player.play_turn(:to))
      if @board[move_from] && @board[move_from].color != player.color
        raise BadMoveError.new("You can only move your pieces! You sly sunnabitch...")
      end
      @board.move(move_from, move_to)
    rescue BadMoveError
      puts "Invalid move!"
      retry
    end
  end

  def to_coord(str) #Converts chess notation to coordinates in Board class
    abc = ("a".."h").to_a
    coords = str.split("")
    x = abc.index(coords[0].downcase)
    y = 8 - coords[1].to_i
    [x, y]
  end
end



#A -> 0
#B -> 1
#C -> 2
#D -> 3
#E -> 4
#F -> 5
#G -> 6
#H -> 7

#1 -> 7
#2 -> 6
#3 -> 5
#4 -> 4
#5 -> 3
#6 -> 2
#7 -> 1
#8 -> 0
