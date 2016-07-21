require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
	describe "GET index" do
		context "user" do
			login_user
			it "returns http success" do
				get :index
				expect(response).to have_http_status(:success)
			end
			let(:other_user) {FactoryGirl.create(:user)}
			let(:my_registered_application) {FactoryGirl.create(:registered_application, user: subject.current_user)}
			let(:other_registered_application) {FactoryGirl.create(:registered_application, user: other_user)}
			it "assigns my_registered_application to registered_applications" do
				get :index
				expect(assigns(:registered_applications)).to eq([my_registered_application])
			end
		end
		context "guest" do
			it "redirects to sign in page" do
				get :index
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "GET show" do
		context "user" do
			login_user
			let(:my_registered_application) {FactoryGirl.create(:registered_application, user: subject.current_user)}
			it "returns http success" do
				get :show, id: my_registered_application
				expect(response).to have_http_status(:success)
			end

			it "assigns my_registered_application to registered_application" do
				get :show, id: my_registered_application
				expect(assigns(:registered_application)).to eq my_registered_application
			end
		end
		context "guest" do
			let(:user) {FactoryGirl.create(:user)}
			let(:users_registered_application) {FactoryGirl.create(:registered_application, user: user)}
			it "redirects to sign in page" do
				get :show, id: users_registered_application
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "GET new" do
		context "user" do
			login_user
			it "returns http success" do
				get :new
				expect(response).to have_http_status(:success)
			end

			it "renders the new template" do
				get :new
				expect(response).to render_template(:new)
			end

			it "expects registered_application to not be nil" do
				get :new
				expect(:registered_application).not_to be_nil
			end
		end
		context "guest" do
			it "redirects to sign in page" do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "POST create" do
		context "user" do
			login_user
			it "assigns the passed in url to registered_application's url" do
				post :create, registered_application: { name: "New Application", url: "http://www.newapplication.com"}
				expect(assigns(:registered_application).url).to eq "http://www.newapplication.com"
			end

			it "increases RegisteredApplication by one" do
				expect{post :create, registered_application: { name: "New Application", url: "http://www.newapplication.com"}}.to change(RegisteredApplication, :count).by 1
			end

			it "redirects to registered_application_path" do
				reg_app = FactoryGirl.build(:registered_application, user: subject.current_user)
				post :create, registered_application: { name: reg_app.name, url: reg_app.url}
				expect(response).to redirect_to RegisteredApplication.last
			end
		end
		context "guest" do
			it "redirects to sign in page" do
				get :create, registered_application: { name: "New Application", url: "http://www.newapplication.com" }
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "DELETE destroy" do
		context "user" do
			login_user
			let!(:my_registered_application) {FactoryGirl.create(:registered_application, user: subject.current_user)}
			it "redirects to index page" do
				delete :destroy, id: my_registered_application
				expect(response).to redirect_to registered_applications_path
			end

			it "deletes the registered_application" do
				old_count = RegisteredApplication.count
				delete :destroy, id: my_registered_application
				expect(old_count - 1).to eq RegisteredApplication.count
			end
		end
		context "guest" do
			let(:user) {FactoryGirl.create(:user)}
			let(:users_registered_application) {FactoryGirl.create(:registered_application, user: user)}
			it "redirects to sign in page" do
				delete :destroy, id: users_registered_application
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end
end
