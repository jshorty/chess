class SlidingPiece < Piece
  def initialize(color, position)
    super
  end

  def all_moves
    possible_moves = []
    move_dirs.each do |move|
      x = @position[0] + move[0]
      y = @position[1] + move[1]
      possible_moves << [x,y]
    end
    possible_moves
  end

  #

  def generate_dirs(dir) #Pass it "directions" and generate all possible directions
    dirs = []
    (1..7).each do |n|
      dir.combination(2).to_a.uniq.map { |dir| dirs << [dir[0]*n,dir[1]*n]}
    end
    dirs
  end

  def diagonal_dirs
    generate_dirs([1,1,-1,-1])
  end

  def horizontal_dirs
    generate_dirs([1,-1,0]).select { |dir| dir[1] == 0}
  end

  def vertical_dirs
    generate_dirs([1,-1,0]).select { |dir| dir[0] == 0}
  end
end
