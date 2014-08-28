module Vedeu
  class Buffer

    attr_reader :back, :front, :interface

    # @param attributes [Hash] The buffer attributes.
    # @param [Hash] attributes
    # @option attributes :back [Hash] The next view to be rendered.
    # @option attributes :front [Hash] The view which is currently on screen.
    # @option attributes :interface [Hash] An attribute form of the interface from
    #   which we can create a new front or back.
    # @return [Buffer]
    def initialize(attributes = {})
      @attributes = attributes

      @back       = attributes.fetch(:back)
      @front      = attributes.fetch(:front)
      @interface  = attributes.fetch(:interface)
    end

    # @param view [Interface]
    # @return [Buffer]
    def enqueue(view)
      merge({ back: view })
    end

    # @return [Buffer]
    def refresh
      return merge({ front: back, back: nil }).render if content_available?
      return clear                                    if no_content_available?
      return render
    end

    # @return [Buffer]
    def render
      Terminal.output(front.to_s)

      self
    end

    # @return [Buffer]
    def clear
      Terminal.output(interface.clear)

      self
    end

    private

    # @return [Buffer]
    def merge(new_attributes)
      Buffer.new(@attributes.merge(new_attributes))
    end

    # @return [TrueClass|FalseClass]
    def content_available?
      !!(back)
    end

    # @return [TrueClass|FalseClass]
    def no_content_available?
      front.nil?
    end

  end
end
