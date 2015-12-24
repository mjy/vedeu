module Vedeu

  module Borders

    # When a {Vedeu::Borders::Border} has a caption, truncate it if
    # the caption is longer than the interface is wide, and pad with a
    # space either side.
    #
    # The caption is displayed within the bottom border of the
    # interface/view.
    #
    # @api private
    #
    class Caption < Vedeu::Borders::Title

      private

      # @return [Fixnum]
      def start_index
        (width - size) - 1
      end

      # @return [Fixnum]
      def y
        geometry.yn
      end

    end # Caption

  end # Borders

end # Vedeu
