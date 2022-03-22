class Orange < ApplicationRecord
  include Blending

  belongs_to :basket
end
