module Vedeu
  module Colour
    class Mask
      def self.define(mask = [])
        new(mask).define
      end

      def initialize(mask = [])
        @mask = mask
      end

      def define
        [foreground, background].join
      end

      private

      attr_reader :mask

      def foreground
        Colour::Foreground.escape_sequence(mask[0])
      end

      def background
        Colour::Background.escape_sequence(mask[1])
      end
    end
  end
end
