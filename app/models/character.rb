class Character < ApplicationRecord
    has_many :image_characters
    has_many :images, through: :image_characters

    has_many :sortings

    validates :character_name,  presence: true,
                                uniqueness: true
end
