require 'rails_helper'



describe "SignUps", type: :system do

  before do
    visit root_path
    click_link "Sign up now!"
  end
#ログイン失敗
  it "user unsuccessfully signs up" do

    fill_in "Name", with: ""
    fill_in "Email", with: "user@invalid"
    fill_in "Password",with: "foo"
    fill_in "Confirmation",with: "bar"

    click_button "Create my account"

    expect(current_path).to eq '/users'
  end
  #ログイン成功
  it "user successfully signs up" do
    expect{

    fill_in "Name", with: "essei"
    fill_in "Email", with: "essei@valid.com"
    fill_in "Password",with: "password"
    fill_in "Confirmation",with: "password"
    click_button "Create my account"
    }.to change(User, :count).by(1)



    expect(page).to have_content 'essei'


  end
end
