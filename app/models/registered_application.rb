class RegisteredApplication < ActiveRecord::Base
	belongs_to :user
	has_many :events

	validate :name, presence: true, uniqueness: true
	validate :url, presence: true, uniqueness: true
	validate :user, presence: true

	scope :belonging_to, -> (user) { where(user: user)}
end
