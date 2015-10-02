class Mug
  attr_accessor :x, :y
  def initialize
    @image = Gosu::Image.new("images/mug.png")
    @height = @image.height
    @width = @image.width
    @x = GameWindow::WIDTH/2 - @width
    @y = GameWindow::HEIGHT - @height
    @z = 1
    @speed = 5
  end

  def update
    if Gosu::button_down?(Gosu::KbLeft)
      @x -= @speed
    elsif Gosu::button_down?(Gosu::KbRight)
      @x += @speed
    elsif Gosu::button_down?(Gosu::KbUp)
      @y -= @speed
    elsif Gosu::button_down?(Gosu::KbDown)
      @y += @speed
    elsif Gosu::button_down?(Gosu::KbReturn)
      @x = GameWindow::WIDTH/2 - @width
      @y = GameWindow::HEIGHT - @height
    end

    @x %= GameWindow::WIDTH
    @y %= GameWindow::HEIGHT
    # puts "x is #{@x}"
    # puts "y is #{@y}"
  end

  def draw
    @image.draw(@x, @y, @z)
  end

end
