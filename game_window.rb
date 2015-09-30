require 'gosu'
require_relative 'mug'
require_relative 'donut'
require_relative 'timer'

class GameWindow < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Dunk the donut"

    @background_image = Gosu::Image.new("images/space.png")

    @mug = Mug.new
    @donuts = []
    @font = Gosu::Font.new(30)
    # @explosion = Gosu::Sample.new("sounds/explosion.wav")
    @time = Timer.new(GameWindow)
    @game_over = false
    @score = 0
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
          # @game_over = true
          @score +=1
          @donuts.delete(donut)
        end

        if donut.off_screen?
          @donuts.delete(donut)
        end

        @time.update
        # puts @time.seconds
        if @time.seconds > 3
          @game_over = true
        end
      end
    end
  end

  def restart
    if Gosu::button_down?(Gosu::KbA)
      initialize
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @mug.draw
    @font.draw("Time: #{@time.seconds}", WIDTH-120, 0, 1, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    @font.draw("Score: #{@score}", 0, 0, 1, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    if @game_over
      @font.draw("GAME OVER", WIDTH/3, HEIGHT/2-20, 2, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
      @font.draw("Press A to start a new game", WIDTH-500, HEIGHT/2+20, 2, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
      restart
    end

    @donuts.each do|donut|
      donut.draw
    end
  end
end

window = GameWindow.new
window.show
