require 'gosu'
require_relative 'mug'
require_relative 'donut'

class GameWindow < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Dunk the donut"

    @background_image = Gosu::Image.new("images/space.png")

    @mug = Mug.new
    @donuts = []
    # @explosion = Gosu::Sample.new("sounds/explosion.wav")
    @game_over = false
  end

  def update
    if !@game_over
      @mug.update

      if rand(100) < 4
        @donuts << Donut.new
      end

      @donuts.each do |donut|
        donut.update
        if Gosu::distance(@mug.x, @mug.y, donut.x, donut.y) < 35
          # @explosion.play
          @game_over = true
        end

        if donut.off_screen?
          @donuts.delete(donut)
        end
      end
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @mug.draw
    @donuts.each do|donut|
      donut.draw
    end
  end
end

window = GameWindow.new
window.show
