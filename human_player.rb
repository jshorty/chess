class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(to_or_from)
    print "Please choose a piece using coordinates (A-H)(1-8) : " if to_or_from == :from
    print "Please choose where to move (A-H)(1-8) : " if to_or_from == :to
    input_str = gets.chomp.downcase
    #Validates proper input format
    until input_str.scan(/\A[a-h]\d\z/)
      print "Please enter valid coordinates (A-H)(1-8) :"
      input_str = gets.chomp.downcase
    end
    input_str
  end
end
