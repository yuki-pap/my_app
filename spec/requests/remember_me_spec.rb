require 'rails_helper'


describe "Remember me", type: :request do
  let!(:user) { FactoryBot.create(:user)}

  context "login with remember_me" do
    it 'remembers cookies' do
      post login_path, params: { session: { email: user.email,
                                      password: user.password,
                                      remember_me: '1'}}
      expect(response.cookies['remember_token']).to_not eq nil
      expect(current_user).to eq user
    end
  end

  context "login without remember_me" do
    it "doesn't remembers cookies" do
      post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      expect(response.cookies['remember_token']).to eq nil


    end
  end
end
