class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(to_or_from)
    case to_or_from
    when :from then prompt_for_piece
    when :to then promt_for_destination
    end

    input_str = gets.chomp.downcase
    while input_str.scan(/\A[a-h]\d\z/).empty?
      print "Please enter valid coordinates (A-H)(1-8) :"
      input_str = gets.chomp.downcase
    end
    input_str
  end

  def prompt_for_piece
    print "Please choose a piece using coordinates (A-H)(1-8) : "
  end

  def prompt_for_destination
    print "Please choose where to move (A-H)(1-8) : "
  end
end
