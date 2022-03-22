class Basket < ApplicationRecord
  has_many :apples
  has_many :oranges
end
