require 'gosu'
require 'yaml'

require_relative './app/storage/levels_storage.rb'

require_relative './app/class/button'
require_relative './app/class/z_order'
require_relative './app/class/player'
require_relative './app/class/object_items'
require_relative './app/class/ui'
require_relative './app/class/song_player'
require_relative './app/class/collector_proxy'
require_relative './app/class/level'
require_relative './app/class/storage_file'
require_relative './public/window'

WindowWidth  = 840
WindowHeight = 680

window = Window.new(WindowWidth, WindowHeight)
window.show
