class Image < ApplicationRecord
    has_many :image_titles
    has_many :titles, through: :image_titles

    has_many :image_characters
    has_many :characters, through: :image_characters

    has_many :sortings
    has_many :users, through: :sortings

    validates :url, presence: true,
                    uniqueness: true

end
