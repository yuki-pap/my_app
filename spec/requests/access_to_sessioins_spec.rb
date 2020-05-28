require 'rails_helper'

describe 'access to sessions', type: :request do
  let!(:user) { FactoryBot.create(:user)}
  # ログイン機能
  describe 'POST #create' do
    it 'log in add redirect to detail page' do
      post login_path, params: { session: {email: user.email,
                                          password: user.password}}
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to be_truthy
    end
  end
  #ログアウト機能テスト
  describe 'DELETE #destroy' do
    it 'log out and redirect to rooturl' do
      delete logout_path
      expect(response).to redirect_to root_path
      expect(is_logged_in?).to be_falsey
    end
  end

end
