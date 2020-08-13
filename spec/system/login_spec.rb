require 'rails_helper'

describe "Login", type: :system do

  before do

    FactoryBot.create(:login_user_with_studies)
    @user = User.find_by(email: "test@example.com")
    visit login_path
  end


#無効な値でのログイン
  describe 'enter an invalid values' do
    before do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログイン'
    end
    it 'gets a flash message' do
      expect(page).to have_selector '.alert-danger',text: 'Invalid email/password combination'
      expect(page).to have_current_path login_path
    end

  end
#有効な値でのログイン,ログアウト
  describe 'enter an valid values' do
    before do

      fill_in 'メールアドレス',with:'test@example.com'
      fill_in 'パスワード',with: 'foobar'
      click_button 'ログイン'

    end
    it 'log_in' do

      expect(page).to have_current_path user_path(@user)
      expect(page).to_not have_link  'Link', href: login_path

      expect(page).to have_link 'ログアウト',href: logout_path


    end
    it 'log_out' do

      visit root_path


      click_link 'ログアウト'
    

      expect(page).to have_current_path root_path
      expect(page).to have_link 'ログイン', href: login_path
      expect(page).to_not have_link nil, href: user_path(@user)
    end

  end


end
