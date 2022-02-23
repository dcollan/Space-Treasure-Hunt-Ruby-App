class UI

  ScoreX = 10
  ScoreY = 10

  MaxScoreX = 10
  MaxScoreY = 30

  AchievedX = 0
  AchievedY = 670
  AchievedHeight = 10

  LevelX = 760
  LevelY = 10

  Yellow = 0xff_ffff00
  Black = 0xff_000000

  LivesX = 10
  LivesXShift = 20
  LivesY = 53

  PressSpaceLow = 210
  PressSpaceHigh = 270

  def initialize
    @font = Gosu::Font.new(20, name: "./app/assets/fonts/VT323/VT323-Regular.ttf")
    @big_font = Gosu::Font.new(60, name: "./app/assets/fonts/VT323/VT323-Regular.ttf")
    @small_font = Gosu::Font.new(30, name: "./app/assets/fonts/VT323/VT323-Regular.ttf")
    @heart = Gosu::Image.new("./app/assets/images/heart.gif")
    @y = 240
    @y_velocity = -0.3
  end

  def draw(game)
    draw_score(game[:score])
    draw_max_score(game[:max_score])
    draw_lives(game[:lives])
    draw_game_over if game[:game_over]
    draw_game_win if game[:game_win]
    draw_begin_game if game[:begin_game]
    draw_helping if game[:helping]
    draw_level(game[:level])
  end

  private

  def draw_score(score)
    @font.draw("Score: #{score}", ScoreX, ScoreY, ZOrder::UI, 1.0, 1.0, Yellow)
  end

  def draw_max_score(max_score)
    @font.draw("Max score: #{max_score}", MaxScoreX, MaxScoreY, ZOrder::UI, 1.0, 1.0, Yellow)
  end

  def draw_lives(number)
    number.times do |index|
      @heart.draw(LivesXShift * index + LivesX, LivesY, ZOrder::UI)
    end
  end

  def draw_game_over
    @big_font.draw_rel("Game Over", WindowWidth / 2, WindowHeight / 3, ZOrder::UI, 0.5, 0.5, 1, 1, Yellow)
    @big_font.draw_rel("Press Space To Play Again", WindowWidth / 2, y + 70, ZOrder::UI, 0.5, 0.5, 1, 1, Yellow)
  end

  def draw_game_win
    @big_font.draw_rel("Winner!!", WindowWidth / 2, WindowHeight / 3, ZOrder::UI, 0.5, 0.5, 1, 1, Yellow)
    @big_font.draw_rel("Press Space To Play Again", WindowWidth / 2, y + 70, ZOrder::UI, 0.5, 0.5, 1, 1, Yellow)
  end

  def draw_begin_game
    @big_font.draw_rel("Space Treasure Hunt!", WindowWidth / 2, WindowHeight / 3, ZOrder::UI, 0.5, 0.5, 1, 1, Yellow)
    @small_font.draw_rel("\nStart Level 1", WindowWidth / 2, WindowHeight - 400, ZOrder::UI, 0.5, 0.5, 1, 1, Yellow)
    @small_font.draw_rel("\nPress Space", WindowWidth / 2, WindowHeight - 340, ZOrder::UI, 0.5, 0.5, 1, 1, Yellow)
  end

  def draw_helping
    @big_font.draw_rel("Rules", WindowWidth / 2, WindowHeight / 3, ZOrder::UI, 0.5, 0.5, 1, 1, Black)
    @small_font.draw_rel("You need to take piece and finish all level", WindowWidth / 2, WindowHeight - 400, ZOrder::UI, 0.5, 0.5, 1, 1, Black)
    @small_font.draw_rel("You have 3 lives, dodge the fire otherwise you lose one life", WindowWidth / 2, WindowHeight - 370, ZOrder::UI, 0.5, 0.5, 1, 1, Black)
    @small_font.draw_rel("You can take a golden appel to win a life", WindowWidth / 2, WindowHeight - 340, ZOrder::UI, 0.5, 0.5, 1, 1, Black)
    @small_font.draw_rel("Press Space To Play", WindowWidth / 2, WindowHeight - 300, ZOrder::UI, 0.5, 0.5, 1, 1, Black)
  end

  def y
    @y += y_velocity
  end

  def y_velocity
    if @y < PressSpaceLow || @y > PressSpaceHigh
      @y_velocity = -@y_velocity
    end
    @y_velocity
  end

  def draw_level(level)
    Gosu::draw_rect(AchievedX, AchievedY, achieved_part(level), AchievedHeight, Yellow, ZOrder::UI)

    @font.draw("Level: #{level[:number]}", LevelX, LevelY, ZOrder::UI, 1.0, 1.0, Yellow)
  end

  def achieved_part(level)
    WindowWidth / level[:goal] * level[:collected]
  end
end
