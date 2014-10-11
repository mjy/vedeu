module Vedeu

  # Repository for storing, retrieving and manipulating the cursor position and
  # visibility for an interface.
  #
  # @api private
  module Cursors

    include Common
    include Repository
    extend self

    # System events which when called will update the cursor position or
    # visibility accordingly for the interface in focus.
    Vedeu.event(:_cursor_up_)      { Cursors.use(:move_up)    }
    Vedeu.event(:_cursor_right_)   { Cursors.use(:move_right) }
    Vedeu.event(:_cursor_down_)    { Cursors.use(:move_down)  }
    Vedeu.event(:_cursor_left_)    { Cursors.use(:move_left)  }
    Vedeu.event(:_cursor_hide_)    { Cursors.use(:hide)       }
    Vedeu.event(:_cursor_show_)    { Cursors.use(:show)       }
    Vedeu.event(:_cursor_refresh_) { Cursors.use(:refresh)    }

    # Adds an interface to the cursors repository.
    #
    # @param attributes [Hash]
    # @return [Hash]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("Registering cursor: '#{attributes[:name]}'")

      storage.store(attributes[:name], {
        name: attributes[:name],
        x: 1,
        y: 1,
        state: :show
      })
    end

    # Saves the attributes in the repository for future use.
    #
    # @param attributes [Hash]
    # @return [Hash]
    def update(attributes)
      return false unless defined_value?(attributes[:name])

      Vedeu.log("Updating cursor: '#{attributes[:name]}'")

      storage.store(attributes[:name], attributes)
    end

    # Perform an action (moving, showing or hiding) and save the new cursor
    # state.
    #
    # @param action [Symbol] A symbol representing the method name to be called
    #   on the Cursor instance.
    # @return [String] The escape sequence sent to the Terminal on completion
    #   of the action.
    def use(action)
      name   = Focus.current
      cursor = Cursor.new(find(name))

      storage.store(name, cursor.send(action))

      Terminal.output(cursor.to_s)
    end

    private

    # Returns an empty collection ready for the storing of cursors by name with
    # current attributes.
    #
    # @api private
    # @example
    #   { 'holmium' => {
    #                    name:     'holmium',
    #                    state:    :show,
    #                    x:        1,
    #                    y:        1 } }
    #
    # @return [Hash]
    def in_memory
      {}
    end

    # @api private
    # @param name [String]
    # @raise [CursorNotFound] When the entity cannot be found with this name.
    # @return [CursorNotFound]
    def not_found(name)
      fail CursorNotFound, "Cursor was not found with this name: #{name.to_s}."
    end

  end # Cursors

end # Vedeu