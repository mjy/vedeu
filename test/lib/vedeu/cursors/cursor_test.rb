require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_cursor_down_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_left_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_origin_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_position_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_reposition_).must_equal(true) }
    # it { Vedeu.bound?(:_cursor_reset_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_right_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_up_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_top_).must_equal(true) }
    it { Vedeu.bound?(:_cursor_bottom_).must_equal(true) }
  end

  module Cursors

    describe Cursor do

      let(:described)   { Vedeu::Cursors::Cursor }
      let(:instance)    { described.new(attributes) }
      let(:attributes)  {
        {
          name:       _name,
          ox:         ox,
          oy:         oy,
          repository: repository,
          visible:    visible,
          x:          x,
          y:          y,
        }
      }
      let(:_name)      { 'silver' }
      let(:ox)         { 3 }
      let(:oy)         { 2 }
      let(:repository) { Vedeu.cursors }
      let(:visible)    { true }
      let(:x)          { 19 }
      let(:y)          { 8 }
      let(:border)     {
        Vedeu::Borders::Border.new(name: _name, enabled: enabled)
      }
      let(:geometry)  {
        Vedeu::Geometries::Geometry.new(
          name: _name,
          x:    5,
          xn:   35,
          y:    5,
          yn:   10
        )
      }
      let(:enabled) { true }

      before do
        Vedeu.borders.stubs(:by_name).returns(border)
        Vedeu.geometries.stubs(:by_name).returns(geometry)
      end

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@name').must_equal('silver') }
        it { subject.instance_variable_get('@ox').must_equal(ox) }
        it { subject.instance_variable_get('@oy').must_equal(oy) }
        it {
          subject.instance_variable_get('@repository').must_equal(repository)
        }
        it { subject.instance_variable_get('@visible').must_equal(true) }
        it { subject.instance_variable_get('@x').must_equal(x) }
        it { subject.instance_variable_get('@y').must_equal(y) }
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:name)
          instance.must_respond_to(:ox)
          instance.must_respond_to(:ox=)
          instance.must_respond_to(:oy)
          instance.must_respond_to(:oy=)
          instance.must_respond_to(:visible)
          instance.must_respond_to(:x=)
          instance.must_respond_to(:y=)
        }
      end

      describe '.store' do
        subject { described.store(attributes) }

        it { subject.must_equal(instance) }
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(name: 'other_cursor') }

          it { subject.must_equal(false) }
        end
      end

      describe '#hide' do
        let(:visible)     { true }
        let(:hide_cursor) {
          Vedeu::Models::Escape
            .new(value: Vedeu::EscapeSequences::Esc.hide_cursor)
        }

        before do
          Vedeu.stubs(:render_output).with(hide_cursor).returns(hide_cursor)
        end

        subject { instance.hide }

        it { subject.must_be_instance_of(Vedeu::Models::Escape) }
      end

      describe '#move_down' do
        let(:x)  { 19 }
        let(:y)  { 8 }
        let(:ox) { 3 }
        let(:oy) { 2 }

        before { Vedeu.stubs(:trigger).with(:_refresh_cursor_, _name) }

        subject { instance.move_down }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(19) }
        it { subject.y.must_equal(8) }
        it { subject.ox.must_equal(3) }
        it { subject.oy.must_equal(3) }
      end

      describe '#move_left' do
        let(:x)  { 19 }
        let(:y)  { 8 }
        let(:ox) { 3 }
        let(:oy) { 2 }

        before { Vedeu.stubs(:trigger).with(:_refresh_cursor_, _name) }

        subject { instance.move_left }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(7) }
        it { subject.y.must_equal(8) }
        it { subject.ox.must_equal(2) }
        it { subject.oy.must_equal(2) }
      end

      describe '#move_origin' do
        let(:x)  { 19 }
        let(:y)  { 8 }
        let(:ox) { 3 }
        let(:oy) { 2 }

        subject { instance.move_origin }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(6) }
        it { subject.y.must_equal(6) }
        it { subject.ox.must_equal(0) }
        it { subject.oy.must_equal(0) }
      end

      describe '#move_right' do
        let(:x)  { 19 }
        let(:y)  { 8 }
        let(:ox) { 3 }
        let(:oy) { 2 }

        before { Vedeu.stubs(:trigger).with(:_refresh_cursor_, _name) }

        subject { instance.move_right }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(9) }
        it { subject.y.must_equal(8) }
        it { subject.ox.must_equal(4) }
        it { subject.oy.must_equal(2) }
      end

      describe '#move_up' do
        let(:x)  { 19 }
        let(:y)  { 8 }
        let(:ox) { 3 }
        let(:oy) { 2 }

        before { Vedeu.stubs(:trigger).with(:_refresh_cursor_, _name) }

        subject { instance.move_up }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(19) }
        it { subject.y.must_equal(6) }
        it { subject.ox.must_equal(3) }
        it { subject.oy.must_equal(1) }
      end

      describe '#ox' do
        subject { instance.ox }

        it { subject.must_equal(3) }

        context 'when < 0' do
          let(:ox) { -2 }

          it { subject.must_equal(0) }
        end
      end

      describe '#oy' do
        subject { instance.oy }

        it { subject.must_equal(2) }

        context 'when < 0' do
          let(:oy) { -4 }

          it { subject.must_equal(0) }
        end
      end

      describe '#position' do
        subject { instance.position }

        it { subject.must_be_instance_of(Vedeu::Geometries::Position) }
      end

      describe '#show' do
        let(:visible) { false }
        let(:show_cursor) {
          Vedeu::Models::Escape
            .new(value: Vedeu::EscapeSequences::Esc.show_cursor)
        }

        before do
          Vedeu.stubs(:render_output).with(show_cursor).returns(show_cursor)
        end

        subject { instance.show }

        it { subject.must_be_instance_of(Vedeu::Models::Escape) }
      end

      describe '#to_a' do
        subject { instance.to_a }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([8, 19]) }
      end

      describe '#to_s' do
        let(:visible) { true }

        subject { instance.to_s }

        it { instance.must_respond_to(:to_str) }
        it { subject.must_be_instance_of(String) }

        context 'when the cursor is visible' do
          it 'returns an visible cursor escape sequence with position' do
            subject.must_equal("\e[8;19H\e[?25h")
          end
        end

        context 'when the cursor is invisible' do
          let(:visible) { false }

          it 'returns the invisible cursor escape sequence with position' do
            subject.must_equal("\e[8;19H\e[?25l")
          end
        end

        context 'when a block is given' do
          subject {
            instance.to_s do
              # ...
            end
          }

          it 'returns the escape sequence to position and set the visibility ' \
             'of the cursor and returns to that position after yielding the '  \
             'block' do
            subject.must_equal("\e[8;19H\e[8;19H\e[?25h")
          end
        end
      end

      describe '#x' do
        subject { instance.x }

        context 'when x is less than tx' do
          let(:x) { -2 }

          it { subject.must_equal(6) }
        end

        context 'when x is less than left' do
          let(:x) { 2 }

          it { subject.must_equal(6) }
        end

        context 'when x is less than bx' do
          let(:x) { 5 }

          it { subject.must_equal(6) }

          context 'when border is not enabled' do
            let(:enabled) { false }

            it { subject.must_equal(5) }
          end
        end

        context 'when x is more than txn' do
          let(:x) { 47 }

          it { subject.must_equal(34) }
        end

        context 'when x is more than right' do
          let(:x) { 37 }

          it { subject.must_equal(34) }
        end

        context 'when x is more than bxn' do
          let(:x) { 35 }

          it { subject.must_equal(34) }

          context 'when border is not enabled' do
            let(:enabled) { false }

            it { subject.must_equal(35) }
          end
        end
      end

      describe '#y' do
        subject { instance.y }

        context 'when y is less than ty' do
          let(:y) { -2 }

          it { subject.must_equal(6) }
        end

        context 'when y is less than top' do
          let(:y) { 2 }

          it { subject.must_equal(6) }
        end

        context 'when y is less than by' do
          let(:y) { 5 }

          it { subject.must_equal(6) }

          context 'when border is not enabled' do
            let(:enabled) { false }

            it { subject.must_equal(5) }
          end
        end

        context 'when y is more than tyn' do
          let(:y) { 17 }

          it { subject.must_equal(9) }
        end

        context 'when y is more than bottom' do
          let(:y) { 12 }

          it { subject.must_equal(9) }
        end

        context 'when y is more than byn' do
          let(:y) { 10 }

          it { subject.must_equal(9) }

          context 'when border is not enabled' do
            let(:enabled) { false }

            it { subject.must_equal(10) }
          end
        end
      end

    end # Cursor

  end # Cursors

  describe 'Bindings' do
    it { Vedeu.bound?(:_hide_cursor_).must_equal(true) }
    # it { Vedeu.bound?(:_cursor_hide_).must_equal(true) }

    it { Vedeu.bound?(:_show_cursor_).must_equal(true) }
    # it { Vedeu.bound?(:_cursor_show_).must_equal(true) }

    it { Vedeu.bound?(:_toggle_cursor_).must_equal(true) }
  end

end # Vedeu
