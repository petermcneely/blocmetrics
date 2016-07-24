class RegisteredApplicationsController < ApplicationController
	before_action :authenticate_user!

	# All of the current user's registered applications.
	def index
		@registered_applications = RegisteredApplication.belonging_to current_user
	end

	# The registered application retrieved by its id.
	def show
		@registered_application = get_registered_application
		@events = @registered_application.events.group_by(&:name)
	end

	# A new application to register under the current user.
	def new
		@registered_application = RegisteredApplication.new
	end

	# Create the newly registered application for the user.
	def create
		@registered_application = RegisteredApplication.new(registered_application_params)
		@registered_application.user = current_user

		if @registered_application.save
			flash[:notice] = "Application successfully registered."
			redirect_to @registered_application
		else
			flash[:alert] = "Unable to register application. Please try again."
			render :new 
		end
	end

	# Delete the registered application for the user.
	def destroy
		@registered_application = get_registered_application

		if @registered_application.destroy
			flash[:notice] = "Application successfully unregistered."
			redirect_to registered_applications_path
		else
			flash[:alert] = "Unable to unregister the application. Please try again."
			render :show
		end
	end

	private

	def registered_application_params
		params.require(:registered_application).permit(:name, :url)
	end

	def get_registered_application
		begin
			RegisteredApplication.belonging_to(current_user).find(params[:id])
		rescue #TO DO: Be more specific with this rescue condition.
			flash[:alert] = "Unable to find that registered application."
			redirect_to registered_applications_path
		end
	end
end
