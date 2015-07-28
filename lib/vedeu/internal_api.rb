module Vedeu

  # Vedeu's internal API methods provide convenient ways to access Vedeu's
  # internals. They are not supposed to be used by client applications as they
  # have limited value there.
  #
  module InternalAPI

    extend Forwardable

    module_function

    # Manipulate the repository of background colours.
    #
    # @example
    #   Vedeu.background_colours
    #
    # @!method background_colours
    # @return [Vedeu::Backgrounds]
    def_delegators Vedeu::Backgrounds, :background_colours

    # Manipulate the repository of borders.
    #
    # @example
    #   Vedeu.borders
    #
    # @!method borders
    # @return [Vedeu::Borders]
    def_delegators Vedeu::Borders, :borders

    # Manipulate the repository of buffers.
    #
    # @example
    #   Vedeu.buffers
    #
    # @!method buffers
    # @return [Vedeu::Buffers]
    def_delegators Vedeu::Buffers, :buffers

    # Manipulate the repository of cursors.
    #
    # @example
    #   Vedeu.cursors
    #
    # @!method cursors
    # @return [Vedeu::Cursors]
    def_delegators Vedeu::Cursors, :cursors

    # Manipulate the repository of events.
    #
    # @example
    #   Vedeu.events
    #
    # @!method events
    # @return [Vedeu::Events]
    def_delegators Vedeu::Events, :events

    # Manipulate the repository of foreground colours.
    #
    # @example
    #   Vedeu.foreground_colours
    #
    # @!method foreground_colours
    # @return [Vedeu::Foregrounds]
    def_delegators Vedeu::Foregrounds, :foreground_colours

    # Manipulate the repository of geometries.
    #
    # @example
    #   Vedeu.geometries
    #
    # @!method geometries
    # @return [Vedeu::Geometries]
    def_delegators Vedeu::Geometries, :geometries

    # Manipulate the repository of groups.
    #
    # @example
    #   Vedeu.groups
    #
    # @!method groups
    # @return [Vedeu::Groups]
    def_delegators Vedeu::Groups, :groups

    # Manipulate the repository of interfaces.
    #
    # @example
    #   Vedeu.interfaces
    #
    # @!method interfaces
    # @return [Vedeu::Interfaces]
    def_delegators Vedeu::Interfaces, :interfaces

    # Manipulate the repository of keymaps.
    #
    # @example
    #   Vedeu.keymaps
    #
    # @!method keymaps
    # @return [Vedeu::Keymaps]
    def_delegators Vedeu::Keymaps, :keymaps

    # Manipulate the repository of menus.
    #
    # @example
    #   Vedeu.menus
    #
    # @!method menus
    # @return [Vedeu::Menus]
    def_delegators Vedeu::Menus, :menus

    # @example
    #   Vedeu.renderer
    #   Vedeu.renderers
    #
    # @!method renderer
    #   @see Vedeu::Renderers#renderer
    # @!method renderers
    #   @see Vedeu::Renderers#renderers
    def_delegators Vedeu::Renderers, :renderer, :renderers

    # Instruct the terminal to resize. This will happen automatically as the
    # terminal recieves SIGWINCH signals.
    #
    # @example
    #   Vedeu.resize
    #
    # @!method resize
    #   @see Vedeu::Terminal#resize
    def_delegators Vedeu::Terminal, :resize

    # Measure the execution time of the code in the given block.
    #
    # @example
    #   Vedeu.timer do
    #     # ... some code here ...
    #   end
    #
    # @!method timer
    #   @see Vedeu::Timer.timer
    def_delegators Vedeu::Timer, :timer

  end # InternalAPI

  extend InternalAPI

end # Vedeu