require 'io/console'
require 'singleton'
require 'timeout'

require_relative 'vedeu/colour/base'
require_relative 'vedeu/colour/foreground'
require_relative 'vedeu/colour/background'

require_relative 'vedeu/colour/mask'
require_relative 'vedeu/colour/translator'

require_relative 'vedeu/composition'
require_relative 'vedeu/grid'
require_relative 'vedeu/row'

require_relative 'vedeu/input/character/multibyte'
require_relative 'vedeu/input/character/standard'
require_relative 'vedeu/input/keyboard'
require_relative 'vedeu/input/parser'
require_relative 'vedeu/input/translator'

require_relative 'vedeu/interface'
require_relative 'vedeu/application'
require_relative 'vedeu/clock'
require_relative 'vedeu/esc'
require_relative 'vedeu/screen'
require_relative 'vedeu/terminal'
require_relative 'vedeu/version'
