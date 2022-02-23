class SongPlayer
  def play(file)
    @song.stop if @song
    @song = Gosu::Song.new(file)
    @song.volume = 0.25
    @song.play(true)
  end

  def play_game_over
    play("./app/assets/songs/In early time.ogg")
  end

  def play_game_win
    play("./app/assets/songs/In early time.ogg")
  end
end
