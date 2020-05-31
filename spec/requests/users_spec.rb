require 'rails_helper'

describe "User pages", type: :request do
 let!(:user){FactoryBot.create(:user)}
 let!(:other_user){FactoryBot.create(:user)}
    describe "GET #new" do
      it "returns http success" do
        get signup_path
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end

    describe "#update" do
      context "as an authorized user" do
        it "updates a user " do


          user_params = FactoryBot.attributes_for(:user, name: "NewName" )

          post login_path, params: { session: { email: user.email,
                                          password: user.password,
                                          remember_me: '1'}}

          patch user_path(user), params: { id: user.id, user: user_params }


          expect(user.reload.name).to eq "NewName"





        end

      end

      context "as a guest" do
        it "redirects to the login page" do
          user_params = FactoryBot.attributes_for(:user, name: "NewName")
          patch user_path(user), params: { id: user.id, user: user_params}
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path


        end

        it "successful edit with frendly forwarding" do
          user_params = FactoryBot.attributes_for(:user, name: "NewName")
          get edit_user_path(user)
          post login_path, params: { session: { email: user.email,
                                          password: user.password,
                                          remember_me: '1'}}
          expect(response).to redirect_to  edit_user_path(user)



        end


      end


    end




    describe "#index" do
      it "redirect login_path with invalid user " do
        get users_path
        expect(response).to redirect_to login_url
      end
    end

    describe "#destroy" do
      let(:admin_user){FactoryBot.create(:user,admin:true)}
      context "as an authorized user" do
        it "deletes a user" do
          post login_path, params: { session: { email: admin_user.email,
                                        password: admin_user.password,
                                        remember_me: '1'}}
          expect{
            delete user_path(admin_user),params: {id: admin_user.id}
          }.to change(User, :count).by(-1)

        end
      end

      context "as an unauthorized user" do
        it "redirect to root_path" do
          post login_path, params: { session: { email: user.email,
                                        password: user.password,
                                      remember_me: '1'}}
          delete user_path(user), params: {id: user.id}
          expect(response).to redirect_to root_path
        end

      end
    end

end
