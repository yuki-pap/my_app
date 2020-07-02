require 'rails_helper'

describe "Edit", type: :system do

  #FactoryBot.create(:login_user_with_studies).studies
  let!(:user){User.find_by(email: "test@example.com")}

  it "successful edit" do

    visit edit_user_path(user)

    visit current_path

    fill_in 'メールアドレス',with:'test@example.com'
    fill_in 'パスワード',with: 'foobar'
    click_button 'ログイン'

    visit current_path

    expect(current_path).to eq edit_user_path(user)

  end




  it "successful edit" do
    visit login_path
    fill_in 'メールアドレス',with:'test@example.com'
    fill_in 'パスワード',with: 'foobar'
    click_button 'ログイン'
    visit user_path(user)
    click_link "ユーザー情報編集"
    fill_in "名前" , with: "Dukepi"
    fill_in "メールアドレス", with: user.email
    click_button 'Save changes'

    expect(current_path).to eq user_path(user)
    expect(user.reload.name).to eq "Dukepi"
  end

  it "unsuccessful edit" do
    visit login_path
    fill_in 'メールアドレス',with:'test@example.com'
    fill_in 'パスワード',with: 'foobar'
    click_button 'ログイン'

    visit user_path(user)
    click_link "ユーザー情報編集"
    fill_in "名前" , with: "Dukepi"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "foo"
    fill_in "パスワード再入力", with: "barr"
    click_button 'Save changes'


    expect(user.reload.name).to_not eq "Dukepi"
  end


end
