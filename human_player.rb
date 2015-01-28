require 'byebug'

class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(to_or_from)
    print "Please choose a piece using coordinates (A-H)(1-8) : " if to_or_from == :from
    print "Please choose where to move (A-H)(1-8) : " if to_or_from == :to
    input_str = gets.chomp.downcase[0..1]
    debugger if input_str == "db"
    #Validates proper input format
    until ("a".."h").to_a.include?(input_str[0]) &&
          (1..8).to_a.include?(input_str[1].to_i) &&
          input_str.length == 2

      print "Please enter valid coordinates (A-H)(1-8) :"
      input_str = gets.chomp.downcase[0..1]
    end
    input_str
  end
end
