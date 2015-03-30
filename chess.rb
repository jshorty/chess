require_relative 'lib/board'
require_relative 'lib/piece'
require_relative 'lib/sliding_piece'
require_relative 'lib/stepping_piece'
require_relative 'lib/rook'
require_relative 'lib/queen'
require_relative 'lib/knight'
require_relative 'lib/king'
require_relative 'lib/bishop'
require_relative 'lib/pawn'
require_relative 'lib/game'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'
require 'colorize'

class BadMoveError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
