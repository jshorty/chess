class Game
  def initialize
      @board = Board.new
      @white = HumanPlayer.new(:white)
      @black = HumanPlayer.new(:black)
  end

  def play
    until @board.checkmate?(:white)
      @white.play_turn
      break if @board.checkmate?(:black)
      @black.play_turn
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
