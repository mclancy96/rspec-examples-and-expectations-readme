# lib/recipe_timer.rb

class RecipeTimer
  attr_reader :duration, :elapsed, :running

  def initialize(duration)
    @duration = duration
    @elapsed = 0
    @running = false
  end

  def start
    @running = true
  end

  def stop
    @running = false
  end

  def reset
    @elapsed = 0
    @running = false
  end

  def tick(seconds)
    return unless @running
    @elapsed += seconds
    @elapsed = @duration if @elapsed > @duration
  end

  def finished?
    @elapsed >= @duration
  end
end
