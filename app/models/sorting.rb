class Sorting < ApplicationRecord
  belongs_to :user
  belongs_to :image
  belongs_to :title, optional: true
  belongs_to :character, optional: true
end
