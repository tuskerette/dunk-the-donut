require 'gosu'
require_relative 'mug'
require_relative 'donut'
require_relative 'special'
require_relative 'bad'
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
    @specials = []
    @bad_donuts = []
    @font = Gosu::Font.new(30)
    @current_song = Gosu::Song.new("songs/motorcycle.mp3")
    @time = Timer.new(GameWindow)
    @game_over = false
    @score = 0
  end

  def update
    if !@game_over
      @mug.update
      @current_song.play
      if rand(100) < 4
        @donuts << Donut.new
      end

      if rand(500) < 4
        @specials << Special.new
      end

      if rand(400) < 4
        @bad_donuts << Bad.new
      end

      @donuts.each do |donut|
        donut.update
        if Gosu::distance(@mug.x, @mug.y, donut.x, donut.y) < 35
          @score +=1
          @donuts.delete(donut)
        end

        if donut.off_screen?
          @donuts.delete(donut)
        end
      end

      @specials.each do |special|
        special.update
        if Gosu::distance(@mug.x, @mug.y, special.x, special.y) < 35
          @score +=5
          @specials.delete(special)
        end

        if special.off_screen?
          @specials.delete(special)
        end
      end

      @bad_donuts.each do |bad|
        bad.update
        if Gosu::distance(@mug.x, @mug.y, bad.x, bad.y) < 35
          @score -=5
          @bad_donuts.delete(bad)
        end

        if bad.off_screen?
          @bad_donuts.delete(bad)
        end
      end

      @time.update
      if @time.seconds == 59
        @game_over = true
      end
    end
  end

  def restart
    if Gosu::button_down?(Gosu::KbSpace)
      initialize
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @mug.draw
    @font.draw("Time: #{@time.seconds}", WIDTH-120, 0, 1, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    @font.draw("Score: #{@score}", 0, 0, 1, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    if @game_over
      @font.draw("GAME OVER", WIDTH-400, HEIGHT/2-20, 2, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
      @font.draw("Press Space to start a new game", WIDTH-530, HEIGHT/2+20, 2, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
      restart
    end

    @donuts.each do|donut|
      donut.draw
    end

    @specials.each do|special|
      special.draw
    end

    @bad_donuts.each do|bad|
      bad.draw
    end
  end
end

window = GameWindow.new
window.show
