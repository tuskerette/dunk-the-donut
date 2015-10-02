class Bad
  attr_accessor :x, :y
  def initialize
    @image = Gosu::Image.new("images/bad_donut.png")
    @width = @image.width
    @height = @image.height
    @x = rand(GameWindow::WIDTH)
    @y = 0
    @z = 1
    @speed = rand(4..7)
  end

  def update
    @y += @speed
  end

  def draw
    @image.draw(@x, @y, @z)
  end

  def off_screen?
    @y > GameWindow::HEIGHT
  end

end
