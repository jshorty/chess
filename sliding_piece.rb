class SlidingPiece < Piece
  def initialize(color, position, board)
    super
  end

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

  def filter_unblocked(moves)
    unblocked = []
    moves.each do |move|
      x,y = move[0],move[1]
      if @board[[x,y]].nil? || @board[[x,y]].color != @color #Target square is valid
        if build_path(@position, move).none? #All squares in between are empty?
          unblocked << move
        end
      end
    end
    unblocked
  end

  def open_path?(end_pos)
    pos = [@position, end_pos].sort
    x1, y1, x2, y2 = pos[0][0], pos[0][1], pos[1][0], pos[1][1]
    x_diff, y_diff = x2 - x1, y2 - y1
    if x_diff != 0 && y_diff != 0 # Scanning diagonal move path
      (1..x_diff - 1).each do |n|
        x = x1 + n
        y_diff > 0? (y = y1 + n):(y = y1 - n) #Determine diagonal directionality
        return false unless open?([x,y])
      end
    elsif x_diff != 0 # Scanning horizontal move path
      (x1 + 1...x2).each { |x| return false unless @board[[x, y1]].nil? }
    elsif y_diff != 0 # Scanning vertical move path
      (y1 + 1...y2).each { |y| return false unless @board[[x1, y]].nil? }
    end
    true
  end


end
