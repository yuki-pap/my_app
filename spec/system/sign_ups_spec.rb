require 'rails_helper'



describe "SignUps", type: :system do

  before do
    visit root_path
    click_link "今すぐ学習を開始する"
  end
#許可されない入力でのユーザー登録失敗
  it "user unsuccessfully signs up" do

    fill_in "名前", with: ""
    fill_in "メールアドレス", with: "user@invalid"
    fill_in "パスワード",with: "foo"
    fill_in "パスワード再入力",with: "bar"

    click_button "登録"

    expect(current_path).to eq '/users'
  end
  #正しい入力でのユーザー登録
  it "user successfully signs up" do
    expect{

    fill_in "名前", with: "essei"
    fill_in "メールアドレス", with: "essei@valid.com"
    fill_in "パスワード",with: "password"
    fill_in "パスワード再入力",with: "password"
    click_button "登録"
    }.to change(User, :count).by(1)



    expect(page).to have_content "Please check your email to activate your account."


  end
end
