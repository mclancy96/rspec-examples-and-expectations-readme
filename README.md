# RSpec: Examples and Expectations: The Heart of RSpec

Welcome to Lesson 4! If RSpec were a movie, this would be the part where the main characters—`describe`, `context`, `it`, and `expect`—step into the spotlight. These are the building blocks of every RSpec test, and by the end of this lesson, you’ll know them like your favorite sitcom cast. We’re going to break down each one, show you how they work together, and give you plenty of examples (and clarifications!) so you’ll never be confused about what goes where.

---

## What Are Examples and Expectations?

In RSpec, you write **examples** (individual test cases) and set **expectations** (what you want your code to do). Think of examples as little stories about your code, and expectations as the plot twists you want to see happen. Every RSpec test is made up of these two things: a scenario (the example) and an outcome you want to see (the expectation).

Let’s clarify with a real-world analogy: Imagine you’re testing a vending machine. An example might be, “When I put in $1 and press B2, I get a bag of chips.” The expectation is, “I expect a bag of chips to come out.”

In code, you’ll see this as a block that describes what you’re testing, and an `expect` statement that says what should happen.

## The Cast of Characters

Let’s meet the stars of the show, one by one!

### `describe`

`describe` is used to group related tests. It’s like the title of a chapter in your code’s story. You’ll almost always start your spec files with a `describe` block.

```ruby
# /spec/calculator_spec.rb
RSpec.describe Calculator do
  # ...tests go here...
end
```

You can use `describe` for classes, methods, or even features. You can also nest `describe` blocks to organize tests for specific methods inside a class-level describe (e.g., `describe Calculator` with a nested `describe "#add"`). This helps keep your specs organized as your codebase grows (and you'll see more of this in Lesson 9):

```ruby
# /spec/string_manipulator_spec.rb
RSpec.describe StringManipulator do
  # ...
end

# /spec/string_manipulator_spec.rb
describe "#reverse" do
  # ...
end

# /spec/calculator_spec.rb
RSpec.describe Calculator do
  describe "#add" do
    # ...tests for add method...
  end
end
```

### `context`

`context` is used to describe a particular situation or state. It’s like a scene in your story. Use `context` to group tests that share a setup or condition.

```ruby
# /spec/calculator_spec.rb
context "when adding positive numbers" do
  # ...tests for this context...
end

context "when adding negative numbers" do
  # ...tests for this context...
end
```

You can nest `context` blocks inside `describe` blocks to organize your tests even more clearly.

### `it`

`it` defines an individual example (test case). It’s the action! Each `it` block should describe one thing your code should do.

```ruby
# /spec/calculator_spec.rb
it "adds two numbers" do
  expect(Calculator.new.add(2, 3)).to eq(5)
end

it "returns a negative result when subtracting a larger number" do
  expect(Calculator.new.subtract(2, 5)).to eq(-3)
end
```

**Tip:** Write `it` descriptions in plain English and avoid technical jargon—future you (and your teammates) will thank you. Clear, readable tests are easier to maintain and debug!

### `expect`

`expect` is how you set an expectation for your code. It’s like saying, “I expect this to happen!”

```ruby
# /spec/calculator_spec.rb
expect(Calculator.new.add(2, 3)).to eq(5)
```

You can use `expect` with any value, method call, or expression. The magic happens when you add a matcher (like `eq`, `eql`, or `equal`) to say what you expect.

## Matchers: eq, eql, equal

Matchers are how you tell RSpec what you expect. Here are three you’ll use a lot:

- `eq`: Checks if two values are equal (using `==`). Use this for most value comparisons in your specs.
- `eql`: Checks if two values are equal and of the same type (e.g., 5 vs 5.0). Use this when you care about both value and type.
- `equal`: Checks if two variables point to the exact same object (object identity). Use this when you want to confirm two variables are literally the same object in memory.

Let’s see some examples and clarify the differences:

```ruby
# /spec/calculator_spec.rb
expect(5 + 5).to eq(10)      # true, because 5 + 5 == 10
expect(5).to eq(5.0)         # true, because 5 == 5.0 in Ruby
expect(5).to eql(5.0)        # false, because 5 (Integer) != 5.0 (Float)
expect(5).to eql(5)          # true, because both are Integer 5
foo = "bar"
bar = foo
expect(foo).to equal(bar)    # true, because foo and bar are the same object
expect("bar").to equal("bar") # false, because these are two different string objects
expect(:foo).to equal(:foo)  # true, because symbols are always the same object
```

Try these out in IRB to see the results for yourself!

## Putting It All Together

Let’s write a full example, step by step, and see how all the pieces fit:

```ruby
# /spec/calculator_spec.rb
RSpec.describe Calculator do
  context "when adding numbers" do
    it "returns the sum of two positive numbers" do
      expect(Calculator.new.add(2, 2)).to eq(4)
    end

    it "returns the sum of a positive and a negative number" do
      expect(Calculator.new.add(5, -3)).to eq(2)
    end
  end

  context "when subtracting numbers" do
    it "returns the difference" do
      expect(Calculator.new.subtract(10, 3)).to eq(7)
    end
  end
end
```

Notice how we use `describe` for the class, `context` for different situations, and `it` for each specific behavior. Each `expect` sets a clear expectation for what should happen.

You can nest both `describe` and `context` blocks to organize your specs as your codebase grows.

You can add as many `context` and `it` blocks as you need to cover all the scenarios you want to test. The more specific your examples, the easier it is to spot bugs and understand what your code is supposed to do.

### Example Output

Here’s what the output might look like when you run the above spec:

```shell
Calculator
  when adding numbers
    returns the sum of two positive numbers
    returns the sum of a positive and a negative number
  when subtracting numbers
    returns the difference

Finished in 0.00123 seconds (files took 0.12345 seconds to load)
3 examples, 0 failures
```

## Practice Prompts

1. Write a `describe` block for a `StringManipulator` class. Inside, add a context for "when reversing a string" and an example that expects `StringManipulator.new.reverse("abc")` to equal "cba". (Hint: Use the file path comment at the top!)
2. Try using `eq`, `eql`, and `equal` in IRB with different types and objects. What differences do you notice? Write down your observations.
3. Why do you think RSpec uses plain English words like `describe` and `expect`? How does this help you (or your teammates) understand the tests?
4. Add more `context` and `it` blocks to your own specs. How does this help organize your tests?
5. Take a spec you’ve already written and rewrite it to be more explicit and organized. What changes?

---

## Resources

- [RSpec Syntax: describe/context/it](https://relishapp.com/rspec/rspec-core/v/3-10/docs/example-groups/describe)
- [RSpec Expectations Documentation](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers)
- [Better Specs: Example Structure](https://www.betterspecs.org/#describe)

*Next: You’ll learn how to read RSpec’s output and use failures to guide your development!*
