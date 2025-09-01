
require_relative '../lib/recipe_timer'

RSpec.describe RecipeTimer do
  describe '#initialize' do
    it 'sets the duration and initializes elapsed to 0' do
      timer = RecipeTimer.new(60)
      expect(timer.duration).to eq(60)
      expect(timer.elapsed).to eq(0)
      expect(timer.running).to eq(false)
    end
  end

  describe '#start and #stop' do
    let(:timer) { RecipeTimer.new(30) }

    it 'starts the timer' do
      timer.start
      expect(timer.running).to be true
    end

    it 'stops the timer' do
      timer.start
      timer.stop
      expect(timer.running).to be false
    end
  end

  describe '#tick' do
    let(:timer) { RecipeTimer.new(10) }

    it 'does not advance if not running' do
      timer.tick(5)
      expect(timer.elapsed).to eq(0)
    end

    it 'advances elapsed time when running' do
      timer.start
      timer.tick(4)
      expect(timer.elapsed).to eq(4)
    end

    it 'does not exceed duration' do
      timer.start
      timer.tick(15)
      expect(timer.elapsed).to eq(10)
    end
  end

  describe '#reset' do
    it 'resets elapsed and stops the timer' do
      timer = RecipeTimer.new(20)
      timer.start
      timer.tick(10)
      timer.reset
      expect(timer.elapsed).to eq(0)
      expect(timer.running).to be false
    end
  end

  describe '#finished?' do
    it 'returns false if not finished' do
      timer = RecipeTimer.new(5)
      timer.start
      timer.tick(3)
      expect(timer.finished?).to be false
    end

    it 'returns true if elapsed equals duration' do
      timer = RecipeTimer.new(5)
      timer.start
      timer.tick(5)
      expect(timer.finished?).to be true
    end

    it 'returns true if elapsed exceeds duration' do
      timer = RecipeTimer.new(5)
      timer.start
      timer.tick(10)
      expect(timer.finished?).to be true
    end
  end

  # Pending specs for students
  it 'is pending: timer should not tick when stopped (student)' do
    pending('Student: Implement a spec to check that tick does not advance when timer is stopped')
    raise 'Unimplemented pending spec'
    # Example: timer = RecipeTimer.new(10); timer.tick(5); expect(timer.elapsed).to eq(0)
  end

  it 'is pending: timer can be restarted after finishing (student)' do
    pending('Student: Implement a spec to check that timer can be restarted after finishing')
    raise 'Unimplemented pending spec'
    # Example: timer = RecipeTimer.new(5); timer.start; timer.tick(5); timer.reset; timer.start; timer.tick(2); expect(timer.elapsed).to eq(2)
  end
end
