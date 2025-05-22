require 'spec_helper'
require_relative '../lib/hash_transformer'

RSpec.describe HashTransformer do
  describe '#call' do
    subject(:transformer) { described_class.new(input) }

    context 'with complex nested hash' do
      let(:input) do
        {
          a: :a1,
          b: [:b1, :b2],
          c: { c1: :c2 },
          d: [:d1, [:d2, :d3], { d4: :d5 }],
          e: { e1: { e2: :e3 }, e4: [:e5, :e6] }
        }
      end

      let(:expected_output) do
        {
          a: { a1: {} },
          b: { b1: {}, b2: {} },
          c: { c1: { c2: {} } },
          d: { d1: {}, d2: {}, d3: {}, d4: { d5: {} } },
          e: { e1: { e2: { e3: {} } }, e4: { e5: {}, e6: {} } }
        }
      end

      it 'transforms complex nested hash correctly' do
        expect(transformer.call).to eq(expected_output)
      end
    end

    context 'with deeply nested hash' do
      let(:input) { { x: { y: { z: :value } } } }
      let(:expected_output) { { x: { y: { z: { value: {} } } } } }

      it 'handles deep nesting correctly' do
        expect(transformer.call).to eq(expected_output)
      end
    end

    context 'with empty hash' do
      let(:input) { {} }

      it 'returns empty hash' do
        expect(transformer.call).to eq({})
      end
    end

    context 'with strings and numbers' do
      let(:input) { { a: "string", b: 42 } }
      let(:expected_output) { { a: { "string" => {} }, b: { 42 => {} } } }

      it 'handles strings and numbers correctly' do
        expect(transformer.call).to eq(expected_output)
      end
    end

    context 'with repeated values in array' do
      let(:input) { { a: [:value, :value] } }
      let(:expected_output) { { a: { value: {} } } }

      it 'merges repeated values into single key' do
        expect(transformer.call).to eq(expected_output)
      end
    end

    context 'with nested arrays' do
      let(:input) { { a: [[:b1, :b2], [:b3]] } }
      let(:expected_output) { { a: { b1: {}, b2: {}, b3: {} } } }

      it 'handles nested arrays correctly' do
        expect(transformer.call).to eq(expected_output)
      end
    end

    context 'with invalid input' do
      let(:input) { "not a hash" }

      it 'raises error for non-hash input' do
        expect { transformer }.to raise_error(ArgumentError, /Input must be a Hash/)
      end
    end
  end
end