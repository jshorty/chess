require 'byebug'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    puts "Welcome to Chess!"
    get_players
    @board.place_starting_pieces
  end

  def play
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
      player.turn_successful
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

  def validate_piece_ownership(player, piece_pos)
    if self.board[piece_pos] && self.board[piece_pos].color != player.color
      raise BadMoveError.new("You can only move your pieces!")
    end
  end

  def winning_message
    if @board.checkmate?(:black)
      self.board.render
      puts "Checkmate. White wins!"
    elsif @board.checkmate?(:white)
      self.board.render
      puts "Checkmate. Black wins!"
    end
  end

  def new_turn_message(player)
    puts "#{player.color.to_s.capitalize}, it is your turn!"
  end

  def get_players
    input = get_yes_or_no("Play as white? (y/n): ")
    if input == "n"
      @white = ComputerPlayer.new(:white, @board)
      @black = HumanPlayer.new(:black, @board)
    else
      @white = HumanPlayer.new(:white, @board)
      input = get_yes_or_no("Play against a human? (y/n): ")
      @black = HumanPlayer.new(:black, @board) if input == "y"
      @black = ComputerPlayer.new(:black, @board) if input == "n"
    end
  end

  def get_yes_or_no(message)
    input = nil
    until input == "y" || input == "n"
      print message
      input = gets.chomp.downcase
    end
    input
  end
end
