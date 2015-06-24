require 'test_helper'

module Vedeu

  describe Log do

    let(:described) { Vedeu::Log }
    let(:_message) {}
    let(:force) {}
    let(:type) {}

    describe '.log' do
      subject { described.log(message: _message, force: force, type: type) }

      context 'when logging has been forced' do
        # it { skip }
      end

      context 'when logging has not been forced' do
        context 'when the configuration requests logging' do
          # it { skip }
        end

        context 'when the configuration does not request logging' do
          # it { skip }
        end
      end
    end

    describe '.logger' do
      subject { described.logger }

      # it { skip }
    end

  end # Log

end # Vedeu
