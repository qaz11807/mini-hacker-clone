class WeightCalculator < ServiceCaller
  def initialize(created_at)
    @created_at = created_at || Time.now
  end

  def call
    @result = calculate_weight
  end

  private

  def base_weight
    100
  end

  def time_factor
    ((Time.now.utc - @created_at) / 1.hour).round
  end

  def gravity_factor
    0.05
  end

  def calculate_weight
    (base_weight - 1) / ((time_factor + 2)**gravity_factor)
  end
end
