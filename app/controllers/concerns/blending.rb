module Blending
  extend ActiveSupport::Concern

  included do
    before_create :make_juice, if: :called_from_apple?
  end

  def make_juice
    # puts "This method is invoked successfully"
  end

  private

  def called_from_apple?
    self.class.to_s == 'Apple'
  end
end