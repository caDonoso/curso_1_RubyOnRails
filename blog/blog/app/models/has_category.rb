class HasCategory < ApplicationRecord
  belongs_to :mountain
  belongs_to :category
end
