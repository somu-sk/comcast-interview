class Apple < ApplicationRecord
  include Blending
  after_create_commit :recalculate_fill_rate

  belongs_to :basket

  private

  def recalculate_fill_rate
    fill_rate = (self.basket.apples.count / self.basket.capacity.to_f) * 100
    self.basket.update(fill_rate: fill_rate)
  end
end
