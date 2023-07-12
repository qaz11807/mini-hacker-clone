class WeightCalculator < ServiceCaller
  def initialize(created_at)
    @created_at = created_at || Time.now
  end

  def call
    @result = calculate_weight
  end

  private

  def base_weight
    50
  end

  # The time interval is adjusted to minutes for ease of observation.
  def time_factor
    ((Time.now.utc - @created_at) / 1.minute).round
  end

  def gravity_factor
    0.1
  end

  def calculate_weight
    (base_weight - 1) / ((time_factor + 2)**gravity_factor)
  end
end
