require 'rails_helper'

describe "User pages", type: :request do
  before do
    #Studiesをもつユーザーの作成
    FactoryBot.create(:login_user_with_studies).studies

  end
  #other_userの作成と、上記で作成したuser,studyを参照するためのlet
  let(:other_user){FactoryBot.create(:user)}
  let(:study){User.find_by(email: "test@example.com").studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))}
  let(:user){User.find_by(email: "test@example.com")}

 #newアクションの機能テスト
    describe "GET #new" do
      it "returns http success" do
        get signup_path
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end


#updateアクションの機能テスト
    describe "#update" do
      context "as an authorized user" do
        it "updates a user " do

          user_params = FactoryBot.attributes_for(:user, name: "NewName" )

          post login_path, params: { session: { email: "test@example.com",
                                          password: "foobar",
                                          remember_me: '1'}}

          patch user_path(user), params: { id: user.id, user: user_params }

          expect(user.reload.name).to eq "NewName"

        end

      end

      context "as a guest" do
        it "redirects to the login page" do
          #ログインしていなければ更新できない
          user_params = FactoryBot.attributes_for(:user, name: "NewName")
          patch user_path(user), params: { id: user.id, user: user_params}
          expect(response).to have_http_status "302"
          expect(response).to redirect_to login_path


        end

        it "successful edit with frendly forwarding" do
          #フレンドリーフォーワーディングのテスト
          user_params = FactoryBot.attributes_for(:user, name: "NewName")
          get edit_user_path(user)
          post login_path, params: { session: { email: "test@example.com",
                                          password: "foobar",
                                          remember_me: '1'}}
          expect(response).to redirect_to edit_user_path(user)

        end
      end
    end


  #indexアクションの機能テスト
    describe "#index" do
      it "redirect login_path with invalid user " do
        get users_path
        expect(response).to redirect_to login_url
      end
    end

  #destroyアクションの機能テスト
    describe "#destroy" do
      #adminをもtたユーザーの作成
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
        it "redirect to login_path" do
          post login_path, params: { session: { email: user.email,
                                        password: user.password,
                                      remember_me: '1'}}
          delete user_path(other_user), params: {id: user.id}
          expect(response).to redirect_to login_path
        end

      end
    end

    #createアクションの機能テスト
    describe "#create" do
      #無効な情報ではユーザーが作成されない
      it "is invalid with invalid signup information" do
        expect {
          post users_path, params: { user: { name: "",
                                             email: "user@example.com",
                                             password: "password",
                                             password_confirmation: "password"}}
        }.to_not change(User, :count)
      end
      #有効な情報かつ、有効化された時ユーザーが作成される
      it "is valid with valid signup information" do
        expect {
          post users_path, params: { user: { name: "ExampleUser",
                                             email: "user@example.com",
                                             password: "password",
                                             password_confirmation: "password"}}
        }.to change(User, :count).by(1)

        expect(response).to redirect_to root_path
        #saveの時のインスタンス変数を取得、格納
        user = assigns(:user)
        #有効化でのログイン
        post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                    remember_me: '1'}}
        expect(session[:user_id]).to eq nil

        #有効化トークンが不正な場合
        get edit_account_activation_path("Invalid token", email: user.email)
        expect(session[:user_id]).to eq nil

        #トークンは正しく、メールアドレスが無効
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        expect(session[:user_id]).to eq nil
        #トークンもメールアドレスも正しい
        get edit_account_activation_path(user.activation_token, email: user.email)
        expect(session[:user_id]).to eq user.id

      end
    end

 #following,followersの機能テスト
    describe "#following,#followers" do
      context "as a loginuser" do
        it "returns success" do
        #ログイン
         post login_path, params: { session: { email: "test@example.com",
                                        password: "foobar",
                                        remember_me: '1'}}
          get following_user_path(user)
          expect(response).to be_success
          get followers_user_path(user)
          expect(response).to be_success
        end

      end

      context "as a guest" do
        it "redirect login_path" do
          get following_user_path(user)
          expect(response).to redirect_to login_path
          get followers_user_path(user)
          expect(response).to redirect_to login_path
        end


      end

    end

end
