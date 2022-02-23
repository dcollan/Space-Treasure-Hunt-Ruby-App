class Level
  attr_reader :collected, :index

  def initialize
    @levels = LevelsStorage::response
    @sound_next_level = Gosu::Sample.new("./app/assets/sound/next-level.wav")
    reset
  end

  def reset
    @collected = 0
    @index = 0
  end

  def song
    current(:song)
  end

  def collect
    @collected += 1
  end

  def goal
    current(:goal)
  end

  def number
    @index + 1
  end

  def completed?
    @collected == goal
  end

  def next
    @index += 1
    @index %= @levels.size
    @collected = 0
    @sound_next_level.play
  end

  def self.level_score_total
    LevelsStorage::levels_gain_count
  end

  def self.level_number
    @index ? @index : 1
  end

  def level_max
    LevelsStorage::levels_size
  end

  def self.level_max
    LevelsStorage::levels_size
  end

  private

  def current(property)
    @levels[@index][property]
  end
end
