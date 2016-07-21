class RegisteredApplication < ActiveRecord::Base
	belongs_to :user
	has_many :events

	validates_presence_of :name, :url, :user

	scope :belonging_to, -> (user) { where(user: user)}
end
