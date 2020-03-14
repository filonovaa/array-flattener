require './array_flattener'

RSpec.describe ArrayFlattener do
  describe '#call' do
    context 'with valid argument' do
      TEST_DATA = [
        {
          nested: [1, [2, 3], [4, [5, [6]]]],
          flattened: [1, 2, 3, 4, 5, 6]
        },
        {
          nested: [1, 2, 3, 4, 5, 6],
          flattened: [1, 2, 3, 4, 5, 6]
        },
        {
          nested: [1],
          flattened: [1]
        },
        {
          nested: [],
          flattened: []
        },
        {
          nested: [[1, 2]],
          flattened: [1, 2]
        },
        {
          nested: [1, [2, 3]],
          flattened: [1, 2, 3]
        },
        {
          nested: [[1, 2], 3],
          flattened: [1, 2, 3]
        },
        {
          nested: [1, [2, 3], 4],
          flattened: [1, 2, 3, 4]
        }
      ].freeze

      TEST_DATA.each do |data|
        it "return valid result for #{data[:nested]}" do
          result = described_class.call(data[:nested])
          expect(result).to eql(data[:flattened])
        end
      end
    end

    context 'with invalid argument' do
      TEST_DATA = [
        {
          nested: [1, 2.0],
          error: '2.0 is not an Integer or Array'
        },
        {
          nested: [1, { key: 'value' }],
          error: '{:key=>"value"} is not an Integer or Array'
        },
        {
          nested: nil,
          error: 'Argument must be an array'
        }
      ].freeze

      TEST_DATA.each do |data|
        it "return valid result for #{data[:nested]}" do
          expect { described_class.call(data[:nested]) }.to(
            raise_error(ArgumentError, data[:error])
          )
        end
      end
    end
  end
end
