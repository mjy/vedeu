require 'test_helper'

require 'vedeu/api/grid'

module Vedeu
  module API
    describe Grid do
      it 'raises an exception if the value is less than 1' do
        proc { Grid.columns(0) }.must_raise(OutOfRange)
      end

      it 'raises an exception if the value is greater than 12' do
        proc { Grid.columns(13) }.must_raise(OutOfRange)
      end

      it 'returns the width if the value is in range' do
        IO.console.stub :winsize, [25, 80] do
          Grid.columns(7).must_equal(42)
        end
      end
    end
  end
end
