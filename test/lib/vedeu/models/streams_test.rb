require 'test_helper'

module Vedeu

  describe Streams do

    let(:described) { Vedeu::Streams }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Streams

end # Vedeu