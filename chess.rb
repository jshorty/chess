require_relative 'board'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'rook'
require_relative 'queen'
require_relative 'knight'
require_relative 'king'
require_relative 'bishop'
require_relative 'pawn'
require_relative 'game'
require_relative 'human_player'
require 'colorize'

class BadMoveError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
