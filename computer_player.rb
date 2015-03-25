class ComputerPlayer
  attr_reader :color, :board

  def initialize(color, board)
    @color = color
    @board = board
    @moving_piece = nil
  end

  def play_turn(to_or_from)
    case to_or_from
    when :from then return select_piece
    when :to then return select_destination
    end
  end

  def get_promotion
    return Queen
  end

  private

  def select_piece
    pieces = self.board.find_pieces(self.color)
    piece = pieces.shuffle.find { |piece| piece.valid_moves.length > 0 }
    @moving_piece = piece
    @moving_piece.position
  end

  def select_destination
    @moving_piece.valid_moves.shuffle.first
  end
end
