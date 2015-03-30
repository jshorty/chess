class SlidingPiece < Piece
  def horizontal_dirs
    generate_dirs([1,-1,0]).select { |dir| dir[1] == 0}
  end

  def vertical_dirs
    generate_dirs([1,-1,0]).select { |dir| dir[0] == 0}
  end

  def diagonal_dirs
    generate_dirs([1,1,-1,-1])
  end

  def open_path_to_position?(end_pos)
    # determine the anticipated change in position
    pos = [@position, end_pos].sort
    x1, y1 = pos[0]
    x2, y2 = pos[1]
    x_diff, y_diff = (x2 - x1), (y2 - y1)

    # search diagonal move path
    if x_diff != 0 && y_diff != 0
      (1..x_diff - 1).each do |delta|
        x = x1 + delta
        # determine directionality of diagonal pat
        y_diff > 0 ? (y = y1 + delta) : (y = y1 - delta)
        return false unless @board.empty?(x,y)
      end
    # search horizontal and vertical move paths
    elsif x_diff != 0
      (x1 + 1...x2).each {|x| return false unless @board.empty?(x, y1)}
    elsif y_diff != 0
      (y1 + 1...y2).each {|y| return false unless @board.empty?(x1, y)}
    end

    true
  end

  private

  def generate_dirs(dir)
    (1..7).each_with_object([]) do |n, dirs|
      dir.permutation(2).to_a.uniq.map do |dir|
        dirs << [(dir[0] * n), (dir[1] * n)]
      end
    end
  end
end
