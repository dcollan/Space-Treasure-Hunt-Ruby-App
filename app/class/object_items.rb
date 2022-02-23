class ObjectItems
  attr_reader :x, :y, :type

  def initialize(type)
    @type = type
    @image = if type == :piece
               Gosu::Image.new("./app/assets/images/piece.png")
             elsif type == :piece_red
               Gosu::Image.new("./app/assets/images/piece_red.png")
             elsif type == :fire
               Gosu::Image.new("./app/assets/images/fire.png")
             elsif type == :golden_apple
               Gosu::Image.new("./app/assets/images/golden_apple.png")
             end

    @min = if Level::level_number > 4
             5.0
           elsif Level::level_number > 3
             4.0
           elsif Level::level_number > 2
             3.0
           else
             2.0
           end

    @max = if Level::level_number > 4
             15.0
           elsif Level::level_number > 3
             12.0
           elsif Level::level_number > 2
             9.0
           else
             5.0
           end

    @velocity = Gosu::random(@min, @max)

    @x = rand * (WindowWidth - @image.width)
    @y = 0
  end

  def update
    if type == :fire
      @y += @velocity + 3.0
    else
      @y += @velocity
    end
    if type == :piece
      @y += @velocity + 1.0
    else
      @y += @velocity
    end
  end

  def draw
    @image.draw(@x, @y, ZOrder::Items)
  end

  def x_center_of_mass
    @x + @image.width / 2
  end

  def y_center_of_mass
    @y
  end

end
