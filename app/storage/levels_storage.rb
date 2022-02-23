class LevelsStorage
  def self.response
    [
      {
        song: './app/assets/songs/Around the Bend.ogg',
        goal: 3, #3
        gain: 10
      },
      {
        song: './app/assets/songs/Around the Bend.ogg',
        goal: 4, #4
        gain: 10
      },
      {
        song: './app/assets/songs/Around the Bend.ogg',
        goal: 5, #5
        gain: 10
      },
      {
        song: './app/assets/songs/Around the Bend.ogg',
        goal: 7, #7
        gain: 10
      },
      {
        song: './app/assets/songs/Around the Bend.ogg',
        goal: 9, #9
        gain: 10
      },
      {
        song: './app/assets/songs/In early time.ogg',
        goal: 12, #12
        gain: 20
      },
      {
        song: './app/assets/songs/In early time.ogg',
        goal: 15, #15
        gain: 20
      },
      {
        song: './app/assets/songs/In early time.ogg',
        goal: 19, #19
        gain: 20
      },
      {
        song: './app/assets/songs/In early time.ogg',
        goal: 23, #23
        gain: 20
      },
      {
        song: './app/assets/songs/In early time.ogg',
        goal: 30, #30
        gain: 20
      }
    ]
  end

  def self.levels_size
    self.response.size
  end


  def self.levels_gain_count
    self.response.sum { |level| level[:gain] * level[:goal] }
  end
end
