class HumanPlayer
  attr_reader :color

  def initialize(color, board)
    @color = color
  end

  def play_turn(to_or_from)
    case to_or_from
    when :from then prompt_for_piece
    when :to then prompt_for_destination
    end

    input_str = gets.chomp.downcase
    while input_str.scan(/\A[a-h]\d\z/).empty?
      print "Please enter valid coordinates (A-H)(1-8): "
      input_str = gets.chomp.downcase
    end
    convert_notation_to_coords(input_str)
  end

  def get_promotion
    prompt_for_promotion

    input_str = gets.chomp.downcase
    while input_str.scan(/\A[qrbk]\z/).empty?
      print "Please enter a valid piece (Q, R, K, B): "
      input_str = gets.chomp.downcase
    end

    case input_str
    when "q" then return Queen
    when "r" then return Rook
    when "k" then return Knight
    when "b" then return Bishop
    end
  end

  def turn_successful
  end

  private

  def prompt_for_promotion
    puts "Your pawn is promoted! Choose an upgrade below."
    print "Queen (Q), Rook (R), Knight (K), or Bishop (B): "
  end

  def prompt_for_piece
    print "Please choose a piece using coordinates (A-H)(1-8): "
  end

  def prompt_for_destination
    print "Please choose where to move (A-H)(1-8): "
  end

  def convert_notation_to_coords(str)
    coords = str.split("")
    x = ("a".."h").to_a.index(coords[0].downcase)
    y = 8 - coords[1].to_i
    [x, y]
  end
end
