module Button
  def self.left?
    Gosu::button_down?(Gosu::KbLeft)
  end

  def self.right?
    Gosu::button_down?(Gosu::KbRight)
  end

  def self.space?
    Gosu::button_down?(Gosu::KbSpace)
  end

  def self.escape?
    Gosu::button_down?(Gosu::KbEscape)
  end

  def self.help?
    Gosu::button_down?(Gosu::KbH)
  end
end
