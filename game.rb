require 'byebug'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    get_players
    @board.place_starting_pieces
  end

  def play
    puts "Welcome to Chess!"
    until @board.checkmate?(:white)
      turn(@white)
      break if @board.checkmate?(:black)
      turn(@black)
    end
    winning_message
  end

  private

  def turn(player)
    begin
      self.board.render
      new_turn_message(player)

      piece_pos = player.play_turn(:from)
      validate_piece_ownership(player, piece_pos)
      end_pos = player.play_turn(:to)

      self.board.move(piece_pos, end_pos)
      check_for_promotion(player, end_pos)
    rescue BadMoveError => error_message
      puts error_message
      retry
    end
  end

  def check_for_promotion(player, pos)
    piece = self.board[pos]
    if piece.class == Pawn && piece.promoted?
      self.board[pos] = get_promoted_piece(player, pos)
    end
  end

  def get_promoted_piece(player, pos)
    new_piece_class = player.get_promotion
    new_piece_class.new(player.color, pos, self.board, true)
  end

  def get_players
    print "Play as white? (y/n): "
    input = gets.chomp.downcase
      until input == "y" || input == "n"
        print "Play as white? (y/n): "
        input = gets.chomp.downcase
      end
    if input == "n"
      @white = ComputerPlayer.new(:white, @board)
      @black = HumanPlayer.new(:black, @board)
    else
      @white = HumanPlayer.new(:white, @board)
      print "Play against a human? (y/n): "
      input = gets.chomp.downcase
        until input == "y" || input == "n"
          print "Play against a human? (y/n): "
          input = gets.chomp.downcase
        end
      if input == "y"
        @black = HumanPlayer.new(:black, @board)
      else
        @black = ComputerPlayer.new(:white, @board)
      end
    end
  end

  def validate_piece_ownership(player, piece_pos)
    if self.board[piece_pos] && self.board[piece_pos].color != player.color
      raise BadMoveError.new("You can only move your pieces!")
    end
  end

  def winning_message
    puts "Checkmate. White wins!" if @board.checkmate?(:black)
    puts "Checkmate. Black wins!" if @board.checkmate?(:white)
  end

  def new_turn_message(player)
    puts "#{player.color.to_s.capitalize}, it is your turn!"
  end
end
