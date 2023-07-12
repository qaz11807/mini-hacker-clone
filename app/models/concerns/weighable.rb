module Weighable
  extend ActiveSupport::Concern

  included do
    before_create :update_weight
    scope :sort_by_weight, -> { order(weight: :desc, created_at: :desc) }
  end

  def update_weight
    service = WeightCalculator.call(created_at)
    raise service.error if service.failed?

    self.weight = service.result
  end

end
