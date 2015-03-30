class ComputerPlayer
  attr_reader :color, :board

  def initialize(color, board)
    @color = color
    @board = board
    @turn_counter = 0
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

  def turn_successful
    @turn_counter += 1
  end

  private

  def select_piece
    return piece_for_fools_mate if fools_mate_possible?
    pieces = self.board.find_pieces(self.color)
    piece = pieces.shuffle.find { |piece| piece.valid_moves.length > 0 }
    @moving_piece = piece
    @moving_piece.position
  end

  def select_destination
    return destination_for_fools_mate if fools_mate_possible?
    @moving_piece.valid_moves.shuffle.first
  end

  def fools_mate_possible?
    return false unless self.color == :black
    case @turn_counter
    when 0 then return self.board[[5, 5]].class == Pawn
    when 1
      return false unless self.board[[5, 5]].class == Pawn
      return self.board[[6,4]].class == Pawn
    end
  end

  def piece_for_fools_mate
    return [4,1] if @turn_counter == 0
    return [3,0] if @turn_counter == 1
  end

  def destination_for_fools_mate
    return [4, 3] if @turn_counter == 0
    return [7, 4] if @turn_counter == 1
  end
end
