require 'vedeu/geometry/position'
require 'vedeu/output/esc'
require 'vedeu/output/html_char'
require 'vedeu/output/presentation'

module Vedeu

  # A Char represents a single character of the terminal. It is a container for
  # the a single character in a {Vedeu::Stream}.
  #
  # Though a multi-character String can be passed as a value, only the first
  # character is returned in the escape sequence.
  #
  class Char

    include Vedeu::Presentation

    # @!attribute [rw] border
    # @return [NilClass|Symbol]
    attr_accessor :border

    # @!attribute [rw] parent
    # @return [Vedeu::Line]
    attr_accessor :parent

    # @!attribute [r] value
    # @return [String]
    attr_reader :value

    # Returns a new instance of Vedeu::Char.
    #
    # @param attributes [Hash]
    # @option attributes value    [String]
    # @option attributes parent   [Vedeu::Line]
    # @option attributes colour   [Vedeu::Colour]
    # @option attributes style    [Vedeu::Style]
    # @option attributes position [Vedeu::Position]
    # @option attributes border   [NilClass|Symbol] A symbol representing the
    #   border 'piece' this Char represents.
    # @return [Char]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @border   = @attributes[:border]
      @colour   = @attributes[:colour]
      @parent   = @attributes[:parent]
      @style    = @attributes[:style]
      @value    = @attributes[:value]
    end

    # @param other [Vedeu::Char]
    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # When {Vedeu::Viewport#padded_lines} has less lines that required to fill
    # the visible area of the interface, it creates a line that contains a
    # single {Vedeu::Char} containing a space (0x20); later,
    # {Vedeu::Viewport#padded_columns} will attempts to call `#chars` on an
    # expected {Vedeu::Line} and fail; this method fixes that.
    #
    # @return [Array]
    def chars
      []
    end

    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value
    end

    # @return [String]
    def inspect
      "<Vedeu::Char '#{Vedeu::Esc.escape(self.to_s)}'>"
    end

    # @return [Vedeu::Position]
    def position
      @position ||= Vedeu::Position.coerce(attributes[:position])
    end

    # Sets the position of the Char.
    #
    # @param value [Vedeu::Position]
    # @return [Vedeu::Position]
    def position=(value)
      @position = Vedeu::Position.coerce(value)
    end

    # Returns the x position for the Char if set.
    #
    # @return [Fixnum|NilClass]
    def x
      position.x if position
    end

    # Returns the y position for the Char if set.
    #
    # @return [Fixnum|NilClass]
    def y
      position.y if position
    end

    # Returns a Hash of all the values before coercion.
    #
    # @note
    #   From this hash we should be able to construct a new instance of
    #   Vedeu::Char, however, at the moment, `:parent` cannot be coerced.
    #
    # @return [Hash]
    def to_hash
      {
        parent:     {
          background: parent_background,
          foreground: parent_foreground,
          style:      parent_style,
        },
        background: '',
        border:     '',
        foreground: '',
        style:      '',
        value:      value,
        x:          x,
        y:          y,
      }
    end

    # @return [String]
    def to_html
      @to_html ||= Vedeu::HTMLChar.render(self)
    end

    private

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        border:   nil,
        colour:   nil,
        parent:   nil,
        position: nil,
        style:    nil,
        value:    '',
      }
    end

  end # Char

end # Vedeu