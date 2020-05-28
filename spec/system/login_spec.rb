require 'rails_helper'

describe "Login", type: :system do

  before do
    visit login_path
  end
#無効な値でのログイン
  describe 'enter an invalid values' do
    before do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
    end
    it 'gets a flash message' do
      expect(page).to have_selector '.alert-danger',text: 'Invalid email/password combination'
      expect(page).to have_current_path login_path
    end

  end
#有効な値でのログイン,ログアウト
  describe 'enter an valid values' do
    before do
      @user = FactoryBot.create(:user,email: 'test@example.com')
      fill_in 'Email',with:'test@example.com'
      fill_in 'Password',with: 'foobar'
      click_button 'Log in'
    end
    it 'log_in' do
      expect(page).to have_current_path user_path(@user)
      expect(page).to_not have_link  'Link', href: login_path
      click_link 'Account'
      expect(page).to have_link 'Log out',href: logout_path


    end
    it 'log_out' do
      click_link 'Account'
      click_link 'Log out'
      expect(page).to have_current_path root_path
      expect(page).to have_link 'Log in', href: login_path
      expect(page).to_not have_link nil, href: user_path(@user)
    end

  end


end
