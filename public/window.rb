class Window < Gosu::Window
  def initialize(width, height)
    super
    self.caption = 'Collect the piece !'

    @background_image = Gosu::Image.new('./app/assets/images/background.jpg')
    @items = []
    @game_over = false
    @game_win = false
    @populate_piece = 0.035
    @populate_fire = 0.040
    @populate_golden_apple = 10
    @populate_max = 5

    @helping = false
    @max_score = 0

    @level = Level.new
    @player = Player.new(CollectorProxy.new(@level))
    @ui = UI.new
    @song_player = SongPlayer.new
    @storage_file = StorageFile.new
    @song_player.play(@level.song)
  end

  def update
    update_begin_game if @storage_file.begin_game
    helping if Button.help? && !@storage_file.begin_game
    close_game if Button.escape?
    reset if new_game?
    reset_helping if @helping && Button.space?
    next_level if @level.completed?

    return if @game_over || @game_win || @storage_file.begin_game || @helping

    update_game_over
    update_game_win
    update_items
    update_player
  end

  def helping
    @helping = true
  end

  def close_game
    @storage_file.close_file
    Gosu::Window.close!
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @items.each(&:draw)
    @player.draw
    @ui.draw(game_state)
  end

  private

  def update_begin_game
    @storage_file.update_begin_game if @storage_file.begin_game && Button.space?
  end

  def new_game?
    new_game = true if @game_over && Button.space?
    new_game = true if @game_win && Button.space?

    new_game
  end

  def update_items
    return if @player.just_lost_a_life?

    populate_items
    @items.each(&:update)
    @items.reject! {|item| item.y > WindowHeight }
  end

  def populate_items
    return if @items.size >= @populate_max

    rand_populate_items(nb_piece: @populate_piece, nb_fire: @populate_fire, nb_golden_apple: @populate_golden_apple)
  end

  def rand_populate_items(nb_piece:, nb_fire:, nb_golden_apple:)
    golden_apple_rand = rand(0..20)
    type = rand
    if type < nb_piece
      if @level.number <= 5
        @items.push(ObjectItems.new(:piece))
      else
        @items.push(ObjectItems.new(:piece_red))
      end
    elsif type < nb_fire
      @items.push(ObjectItems.new(:fire))
      @items.push(ObjectItems.new(:golden_apple)) if golden_apple_rand == @populate_golden_apple
    end
  end

  def update_player
    @player.update(@items)
  end

  def update_game_over
    return unless @player.lives <= 0

    @game_over = true
    update_max_score
    @song_player.play_game_over
    @storage_file.update_game_over
  end

  def update_game_win
    return unless @player.max_score?

    win_game
  end

  def win_game
    @game_win = true
    update_max_score
    @song_player.play_game_win
    @storage_file.update_game_win
  end

  def update_max_score
    @max_score = @player.score if@player.score > @max_score
  end

  def game_state
    {
      score: @player.score,
      max_score: @max_score,
      lives: @player.lives,
      game_over: @game_over,
      game_win: @game_win,
      begin_game: @storage_file.begin_game,
      helping: @helping,
      level: {
        goal: @level.goal,
        number: @level.number,
        collected: @level.collected,
      },
    }
  end

  def reset
    @items = []
    @player.reset
    @level.reset
    @song_player.play(@level.song)
    @game_over = false
    @game_win = false
  end

  def reset_helping
    @helping = false
  end

  def next_level
    if @level.number == @level.level_max
      win_game
    else
      @level.next
      @song_player.play(@level.song) if @level.number == 6
      @populate_fire += 0.005 if @populate_max >= 10
      @populate_max += 1 if @populate_max <= 14
    end
  end
end
