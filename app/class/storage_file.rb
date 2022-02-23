class StorageFile
  attr_accessor :file, :begin_game

  def initialize
    @file = File.new("./app/storage/game.txt", 'w')
    @file_open = File.open("./app/storage/game.txt")
    @begin_game = true if @file_open.select { |line| line != 'game_start' }
  end

  def update_begin_game
    @begin_game = false
    write_in_storage_file('game_start')
  end

  def update_game_win
    write_in_storage_file('win')
  end

  def update_game_over
    write_in_storage_file('game_over')
  end

  def write_in_storage_file(arg)
    @file.puts arg
  end

  def close_file
    @file.close
  end
end
