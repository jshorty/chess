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
  def diagonal_dirs
    dirs = []
    (1..7).each do |n|
      [[n,n],[n,-n],[-n,n],[-n,-n]].map { |dir| diag << dir}
    end
    dirs
  end

  def horizontal_dirs
    horiz_dirs = []
    (1..7).each do |n|
      [[n,0],[-n,0]].map { |dir| horiz_dirs << dir}
    end
    horiz_dirs
  end

  def vertical_dirs
    vert_dirs = []
    (1..7).each do |n|
      [[0,n],[0,-n]].map { |dir| vert_dirs << dir}
    end
    vert_dirs
  end
  
end
