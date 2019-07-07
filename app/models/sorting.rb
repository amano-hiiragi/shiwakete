class Sorting < ApplicationRecord
  belongs_to :user
  belongs_to :image
  belongs_to :title
  belongs_to :character
end
