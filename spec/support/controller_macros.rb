module ControllerMacros
	def login_admin
		let(:user) { create(:user, :admin_user) }
		before :each do
		    @request.env["devise.mapping"] = Devise.mappings[:user] 
		    sign_in user
  		end
	end

	def login_user
		let(:user) { create(:user, :new_user) }
		before :each do
		    @request.env["devise.mapping"] = Devise.mappings[:user]
		    sign_in user
  		end
	end
end