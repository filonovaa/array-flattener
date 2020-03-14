# The array flattener.
module ArrayFlattener
  # Flattens array of arbitrarily nesting depth
  #
  # @example
  #   ArrayFlattener.call([1, [2, 3]]) # => [1, 2, 3]
  #   ArrayFlattener.call([1, [2, [3, 4], 5], 6]) # => [1, 2, 3, 4, 5, 6]
  #
  # @param [Array] array can contain only integer or an array
  # @return [Array] return flattened array
  def self.call(array)
    raise ArgumentError, 'Argument must be an array' unless array.is_a? Array

    flattened_array = []
    array.each do |element|
      case element
      when Array
        flattened_array.concat(call(element))
      when Integer
        flattened_array << element
      else
        raise ArgumentError, "#{element} is not an Integer or Array"
      end
    end

    flattened_array
  end
end
