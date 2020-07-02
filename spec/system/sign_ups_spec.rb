require 'rails_helper'



describe "SignUps", type: :system do

  before do
    visit root_path
    click_link "新規登録して利用する"
  end
#許可されない入力でのユーザー登録失敗
  it "user unsuccessfully signs up" do

    fill_in "名前", with: ""
    fill_in "メールアドレス", with: "user@invalid"
    fill_in "パスワード",with: "foo"
    fill_in "パスワード再入力",with: "bar"

    click_button "Create my account"

    expect(current_path).to eq '/users'
  end
  #正しい入力でのユーザー登録
  it "user successfully signs up" do
    expect{

    fill_in "名前", with: "essei"
    fill_in "メールアドレス", with: "essei@valid.com"
    fill_in "パスワード",with: "password"
    fill_in "パスワード再入力",with: "password"
    click_button "Create my account"
    }.to change(User, :count).by(1)



    expect(page).to have_content "Please check your email to activate your account."


  end
end
