require 'byebug'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @white = HumanPlayer.new(:white)
    @black = HumanPlayer.new(:black)
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

      piece_pos = select_piece(player)
      validate_piece_ownership(player, piece_pos)
      end_pos = select_end_pos(player)

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
    new_piece_class = player.prompt_for_promotion
    new_piece_class.new(player.color, pos, self.board, true)
  end

  def select_piece(player)
    convert_notation_to_coords(player.play_turn(:from))
  end

  def select_end_pos(player)
    convert_notation_to_coords(player.play_turn(:to))
  end

  def validate_piece_ownership(player, piece_pos)
    if self.board[piece_pos] && self.board[piece_pos].color != player.color
      raise BadMoveError.new("You can only move your pieces!")
    end
  end

  def convert_notation_to_coords(str)
    coords = str.split("")
    x = ("a".."h").to_a.index(coords[0].downcase)
    y = 8 - coords[1].to_i
    [x, y]
  end

  def winning_message
    puts "Checkmate. White wins!" if @board.checkmate?(:black)
    puts "Checkmate. Black wins!" if @board.checkmate?(:white)
  end

  def new_turn_message(player)
    puts "#{player.color.to_s.capitalize}, it is your turn!"
  end
end
