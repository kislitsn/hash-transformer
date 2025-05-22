class HashTransformer
  def initialize(input)
    raise ArgumentError, "Input must be a Hash, got #{input.class}" unless input.is_a?(Hash)
    @input = input
  end

  def call
    transform(@input)
  end

  private

  def transform(value)
    case value
    when Hash
      value.each_with_object({}) do |(k, v), result|
        result[k] = transform(v)
      end
    when Array
      value.each_with_object({}) do |v, result|
        transformed = transform(v)
        transformed.each { |k, v2| result[k] = v2 }
      end
    when Symbol, String, Numeric
      { value => {} }
    else
      raise ArgumentError, "Unsupported type #{value.class} for value: #{value.inspect}"
    end
  end
end