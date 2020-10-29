class Book < ApplicationRecord
	validates :body, presence: true, length: { maximum: 200 }
	validates :title, presence: true
	belongs_to :user
end
