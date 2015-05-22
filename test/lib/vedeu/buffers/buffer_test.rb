require 'test_helper'

module Vedeu

  describe Buffer do

    let(:described)  { Vedeu::Buffer }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        name:     _name,
        back:     back,
        front:    front,
        previous: previous,
      }
    }
    let(:_name)     { 'krypton' }
    let(:back)      {}
    let(:front)     {}
    let(:previous)  {}
    let(:interface) {}

    before do
      Vedeu.stubs(:trigger)
      # Vedeu.interfaces.stubs(:by_name).returns(interface)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@back').must_equal(back) }
      it { instance.instance_variable_get('@front').must_equal(front) }
      it { instance.instance_variable_get('@previous').must_equal(previous) }
      it do
        instance.instance_variable_get('@repository').must_equal(Vedeu.buffers)
      end
    end

    describe '#add' do
      let(:back) {
        Vedeu.interface 'buffer' do
          lines do
            line 'old_back'
          end
        end
      }
      let(:content) {
        Vedeu.interface 'buffer' do
          lines do
            line 'new_back'
          end
        end
      }

      subject { instance.add(content) }

      it { subject.must_equal(true) }

      it 'replaces the back buffer with the content' do
        instance.back.must_equal(back)

        subject

        instance.back.must_equal(content)
      end
    end

    describe '#clear' do
      subject { instance.clear }

      context 'when the clear buffer is empty' do
        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the clear buffer is not empty' do
        # it { subject.must_be_instance_of(Array) }
      end
    end

    describe '#hide' do
      subject { instance.hide }

      context 'when the interface is visible' do
      end

      context 'when the interface is not visible' do
        it { subject.must_be_instance_of(NilClass) }
      end
    end

    describe '#show' do
      subject { instance.show }

      context 'when the interface is visible' do
        # it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the interface is not visible' do
      end
    end

    # describe '#render' do
    #   before { Vedeu::Output.stubs(:render) }

    #   subject { instance.render }

    #   it { subject.must_be_instance_of(Array) }

    #   context 'when there is content on the back buffer' do
    #     let(:back) {
    #       Vedeu.interface 'buffer' do
    #         lines do
    #           line 'old_back'
    #         end
    #       end
    #     }
    #     let(:front) {
    #       Vedeu.interface 'buffer' do
    #         lines do
    #           line 'front'
    #         end
    #       end
    #     }
    #     let(:previous) {
    #       Vedeu.interface 'buffer' do
    #         lines do
    #           line 'previous'
    #         end
    #       end
    #     }
    #     let(:buffer) { :back }

    #     it { subject.must_equal([back]) }

    #     it 'replaces the previous buffer with the front buffer' do
    #       subject
    #       instance.previous.must_equal(front)
    #     end

    #     it 'replaces the front buffer with the back buffer' do
    #       subject
    #       instance.front.must_equal(back)
    #     end

    #     it 'replaces the back buffer with an empty buffer' do
    #       subject
    #       instance.back.must_equal(nil)
    #     end
    #   end

    #   context 'when there is no content on the back buffer' do
    #     let(:buffer) { :back }

    #     it { subject.must_equal([]) }
    #   end

    #   context 'when there is content on the front buffer' do
    #     let(:buffer) { :front }
    #     let(:front) {
    #       Vedeu.interface 'buffer' do
    #         lines do
    #           line 'front'
    #         end
    #       end
    #     }

    #     it { subject.must_equal([front]) }
    #   end

    #   context 'when there is no content on the front buffer' do
    #     let(:buffer) { :front }

    #     it { subject.must_equal([]) }
    #   end

    #   context 'when there is content on the previous buffer' do
    #     let(:buffer) { :previous }
    #     let(:previous) {
    #       Vedeu.interface 'buffer' do
    #         lines do
    #           line 'old_back'
    #         end
    #       end
    #     }

    #     it { subject.must_equal([previous]) }
    #   end

    #   context 'when there is no content on the previous buffer' do
    #     let(:buffer) { :previous }

    #     it { subject.must_equal([]) }
    #   end
    # end

  end # Buffer

end # Vedeu
