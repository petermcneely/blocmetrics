class Event < ActiveRecord::Base
	belongs_to :registered_application

	validates_presence_of :name, :registered_application
end
