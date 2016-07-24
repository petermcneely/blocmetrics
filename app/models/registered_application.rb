class RegisteredApplication < ActiveRecord::Base
	belongs_to :user
	has_many :events

	validates :name, presence: true, uniqueness: true
	validates :url, presence: true, uniqueness: true
	validates :user, presence: true

	scope :belonging_to, -> (user) { where(user: user)}
end
