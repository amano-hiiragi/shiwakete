class Title < ApplicationRecord
    has_many :image_titles
    has_many :images, through: :image_titles

    validates :title_of_work,   presence: true,
                                uniqueness: true
end
