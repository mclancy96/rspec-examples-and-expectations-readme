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
# /spec/examples_spec.rb
RSpec.describe RecipeTimer do
  # ...tests go here...
end
```

You can use `describe` for classes, methods, or even features. You can also nest `describe` blocks to organize tests for specific methods inside a class-level describe (e.g., `describe Calculator` with a nested `describe "#add"`). This helps keep your specs organized as your codebase grows (and you'll see more of this in Lesson 9):

```ruby
# /spec/examples_spec.rb
RSpec.describe RecipeTimer do
  describe "#start" do
    # ...
  end
  describe "#tick" do
    # ...
  end
end
```

### `context`

`context` is used to describe a particular situation or state. It’s like a scene in your story. Use `context` to group tests that share a setup or condition.

```ruby
# /spec/examples_spec.rb
context "when timer is running" do
  # ...tests for this context...
end

context "when timer is stopped" do
  # ...tests for this context...
end
```

You can nest `context` blocks inside `describe` blocks to organize your tests even more clearly.

### `it`

`it` defines an individual example (test case). It’s the action! Each `it` block should describe one thing your code should do.

it "returns a negative result when subtracting a larger number" do

```ruby
# /spec/examples_spec.rb
it "starts the timer" do
  timer = RecipeTimer.new(10)
  timer.start
  expect(timer.running).to be true
end

it "ticks up elapsed time when running" do
  timer = RecipeTimer.new(10)
  timer.start
  timer.tick(3)
  expect(timer.elapsed).to eq(3)
end
```

**Tip:** Write `it` descriptions in plain English and avoid technical jargon—future you (and your teammates) will thank you. Clear, readable tests are easier to maintain and debug!

### `expect`

`expect` is how you set an expectation for your code. It’s like saying, “I expect this to happen!”

```ruby
# /spec/examples_spec.rb
expect(timer.elapsed).to eq(3)
```

You can use `expect` with any value, method call, or expression. The magic happens when you add a matcher (like `eq`, `eql`, or `equal`) to say what you expect.

## Matchers: eq, eql, equal

Matchers are how you tell RSpec what you expect. Here are three you’ll use a lot:

- `eq`: Checks if two values are equal (using `==`). Use this for most value comparisons in your specs.
- `eql`: Checks if two values are equal and of the same type (e.g., 5 vs 5.0). Use this when you care about both value and type.
- `equal`: Checks if two variables point to the exact same object (object identity). Use this when you want to confirm two variables are literally the same object in memory.

Let’s see some examples and clarify the differences:

```ruby
# /spec/examples_spec.rb
expect(RecipeTimer.new(10).duration).to eq(10)      # true, because duration == 10
expect(RecipeTimer.new(5).duration).to eql(5)       # true, both are Integer 5
timer1 = RecipeTimer.new(10)
timer2 = timer1
expect(timer1).to equal(timer2)                     # true, same object
expect(RecipeTimer.new(10)).not_to equal(RecipeTimer.new(10)) # false, different objects
```

Try these out in IRB to see the results for yourself!

## Putting It All Together

Let’s write a full example, step by step, and see how all the pieces fit:

```ruby
# /spec/examples_spec.rb
RSpec.describe RecipeTimer do
  context "when ticking up time" do
    it "does not advance if not running" do
      timer = RecipeTimer.new(10)
      timer.tick(5)
      expect(timer.elapsed).to eq(0)
    end

    it "advances when running" do
      timer = RecipeTimer.new(10)
      timer.start
      timer.tick(4)
      expect(timer.elapsed).to eq(4)
    end
  end

  context "when resetting" do
    it "resets elapsed and stops the timer" do
      timer = RecipeTimer.new(20)
      timer.start
      timer.tick(10)
      timer.reset
      expect(timer.elapsed).to eq(0)
      expect(timer.running).to be false
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
RecipeTimer
  when ticking up time
    does not advance if not running
    advances when running
  when resetting
    resets elapsed and stops the timer

Finished in 0.00123 seconds (files took 0.12345 seconds to load)
3 examples, 0 failures
```

## Getting Hands-On

This lesson repo is set up for you to get hands-on practice with RSpec's examples and expectations using a real-world RecipeTimer domain.

**To get started:**

1. **Fork and Clone** this repository to your own GitHub account and local machine.
2. **Install dependencies:**

   ```sh
   bundle install
   ```

3. **Run the specs:**

   ```sh
   bin/rspec
   ```

4. **Explore the code:**

    - The main domain code is in `lib/recipe_timer.rb`.
    - The robust example specs are in `spec/examples_spec.rb`.

5. **Implement the pending specs:**

    - There are at least two pending specs marked with `pending` in `spec/examples_spec.rb`.
    - Your task: Remove the `pending` line and implement the expectation so the spec passes.

6. **Experiment:**

    - Try adding your own examples using `describe`, `context`, `it`, and `expect` with RecipeTimer.
    - Make the specs fail on purpose to see the error messages and learn from them.

All specs should pass except the pending ones. When you finish, all specs should be green!

---

## Resources

- [RSpec Syntax: describe/context/it](https://relishapp.com/rspec/rspec-core/v/3-10/docs/example-groups/describe)
- [RSpec Expectations Documentation](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers)
- [Better Specs: Example Structure](https://www.betterspecs.org/#describe)

*Next: You’ll learn how to read RSpec’s output and use failures to guide your development!*
