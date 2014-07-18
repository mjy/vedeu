require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/composition'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe Composition do
    describe '#interfaces' do
      it 'returns a collection of interfaces' do
        Composition.new({
          interfaces: {
            name:   'dummy',
            width:  40,
            height: 25
          }
        }).interfaces.first.must_be_instance_of(Interface)
      end

      it 'returns an empty collection when no interfaces are associated' do
        Composition.new.interfaces.must_be_empty
      end
    end

    describe '.enqueue' do
      it 'returns a collection of interfaces' do
        Composition.enqueue({
          interfaces: [
            { name: 'enq1', lines: { streams: { text: 'Composition.enqueue 1' } } },
            { name: 'enq2', lines: { streams: { text: 'Composition.enqueue 2' } } }
          ]
        }).interfaces.first.must_be_instance_of(Interface)
      end

      it 'enqueues the interfaces for rendering' do
        Composition.enqueue({
          interfaces: [
            { name: 'enq1', lines: { streams: { text: 'Composition.enqueue 3' } } },
            { name: 'enq2', lines: { streams: { text: 'Composition.enqueue 4' } } }
          ]
        }).interfaces.first.enqueued?.must_equal(true)
      end
    end

    describe '#to_json' do
      it 'returns the model as JSON' do
        attributes = { interfaces: [{ name: 'Composition#to_json', width: 5, height: 5, colour: { foreground: '#ffff33', background: '#ffff77' } }] }

        Composition.new(attributes).to_json.must_equal("{\"interfaces\":[{\"colour\":{\"foreground\":\"\\u001b[38;5;227m\",\"background\":\"\\u001b[48;5;228m\"},\"style\":\"\",\"name\":\"Composition#to_json\",\"lines\":[],\"y\":1,\"x\":1,\"z\":1,\"width\":5,\"height\":5,\"current\":\"\",\"cursor\":true}]}")
      end
    end

    describe '#to_s' do
      it 'returns the stringified content for a single interface, single line, single stream' do
        InterfaceRepository.create({ name: 'int1_lin1_str1', y: 3, x: 3, width: 10, height: 3 })
        json = File.read('test/support/json/int1_lin1_str1.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...")
      end

      it 'returns the stringified content for a single interface, single line, multiple streams' do
        InterfaceRepository.create({ name: 'int1_lin1_str3', y: 3, x: 3, width: 10, height: 3 })
        json = File.read('test/support/json/int1_lin1_str3.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...")
      end

      it 'returns the stringified content for a single interface, multiple lines, single stream' do
        InterfaceRepository.create({ name: 'int1_lin2_str1', y: 3, x: 3, width: 10, height: 3 })
        json = File.read('test/support/json/int1_lin2_str1.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[4;3HSome text...")
      end

      it 'returns the stringified content for a single interface, multiple lines, multiple streams' do
        InterfaceRepository.create({ name: 'int1_lin2_str3', y: 3, x: 3, width: 10, height: 3 })
        json = File.read('test/support/json/int1_lin2_str3.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...\e[4;3HSome text... more text...")
      end

      it 'returns the stringified content for a single interface, multiple lines, multiple streams, streams contain styles' do
        json = File.read('test/support/json/int1_lin2_str3_styles.json')
        attributes = Oj.load(json, symbol_keys: true)
        InterfaceRepository.create({ name: 'int1_lin2_str3_styles', y: 3, x: 3, width: 10, height: 3 })

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...")
      end

      it 'returns the stringified content for multiple interfaces, single line, single stream' do
        InterfaceRepository.create({ name: 'int2_lin1_str1_1', y: 3, x: 3, width: 10, height: 3 })
        InterfaceRepository.create({ name: 'int2_lin1_str1_2', y: 6, x: 6, width: 10, height: 3 })
        json = File.read('test/support/json/int2_lin1_str1.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6HSome text...")
      end

      it 'returns the stringified content for multiple interfaces, single line, multiple streams' do
        InterfaceRepository.create({ name: 'int2_lin1_str3_1', y: 3, x: 3, width: 10, height: 3 })
        InterfaceRepository.create({ name: 'int2_lin1_str3_2', y: 6, x: 6, width: 10, height: 3 })
        json = File.read('test/support/json/int2_lin1_str3.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6HSome text... more text...")
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, single stream' do
        InterfaceRepository.create({ name: 'int2_lin2_str1_1', y: 3, x: 3, width: 10, height: 3 })
        InterfaceRepository.create({ name: 'int2_lin2_str1_2', y: 6, x: 6, width: 10, height: 3 })
        json = File.read('test/support/json/int2_lin2_str1.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[4;3HSome text...\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text...\e[4;3HSome text...")
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, multiple streams' do
        InterfaceRepository.create({ name: 'int2_lin2_str3_1', y: 3, x: 3, width: 10, height: 3 })
        InterfaceRepository.create({ name: 'int2_lin2_str3_2', y: 6, x: 6, width: 10, height: 3 })
        json = File.read('test/support/json/int2_lin2_str3.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3HSome text... more text...\e[4;3HSome text... more text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6HSome text... more text...\e[7;6HSome text... more text...")
      end

      it 'returns the stringified content for multiple interfaces, multiple lines, multiple streams, streams contain styles' do
        InterfaceRepository.create({ name: 'int2_lin2_str3_styles_1', y: 3, x: 3, width: 10, height: 3 })
        InterfaceRepository.create({ name: 'int2_lin2_str3_styles_2', y: 6, x: 6, width: 10, height: 3 })
        json = File.read('test/support/json/int2_lin2_str3_styles.json')
        attributes = Oj.load(json, symbol_keys: true)

        Composition.new(attributes).to_s.must_equal("\e[3;3H          \e[3;3H\e[4;3H          \e[4;3H\e[5;3H          \e[5;3H\e[3;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[4;3H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[6;6H          \e[6;6H\e[7;6H          \e[7;6H\e[8;6H          \e[8;6H\e[6;6H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...\e[7;6H\e[38;5;16m\e[48;5;21m\e[24m\e[21m\e[27m\e[4mSome text...\e[38;5;226m\e[48;5;46m\e[24m\e[21m\e[27m \e[38;5;231m\e[48;5;201m\e[1mmore text...")
      end
    end
  end
end
