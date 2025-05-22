## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kislitsn/hash-transformer.git
   cd hash-transformer
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

## Running Tests

Run the RSpec tests:
```bash
bundle exec rspec
```

## Usage

```ruby
input = {
  a: :a1,
  b: [:b1, :b2],
  c: { c1: :c2 }
}
transformer = HashTransformer.new(input)
result = transformer.call
# => { a: { a1: {} }, b: { b1: {}, b2: {} }, c: { c1: { c2: {} } } }
```
