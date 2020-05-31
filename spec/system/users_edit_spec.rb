require 'rails_helper'

describe "Edit", type: :system do

  let!(:user){FactoryBot.create(:user,email: 'test@example.com')}

  it "successful edit" do

    visit edit_user_path(user)

    visit current_path

    fill_in 'Email',with:'test@example.com'
    fill_in 'Password',with: 'foobar'
    click_button 'Log in'

    visit current_path

    expect(current_path).to eq edit_user_path(user)

  end




  it "successful edit" do
    visit login_path
    fill_in 'Email',with:'test@example.com'
    fill_in 'Password',with: 'foobar'
    click_button 'Log in'
    visit user_path(user)
    click_link "Settings"
    fill_in "Name" , with: "Dukepi"
    fill_in "Email", with: user.email
    click_button 'Save changes'

    expect(current_path).to eq user_path(user)
    expect(user.reload.name).to eq "Dukepi"
  end

  it "unsuccessful edit" do
    visit login_path
    fill_in 'Email',with:'test@example.com'
    fill_in 'Password',with: 'foobar'
    click_button 'Log in'

    visit user_path(user)
    click_link "Settings"
    fill_in "Name" , with: "Dukepi"
    fill_in "Email", with: user.email
    fill_in "Password", with: "foo"
    fill_in "Confirmation", with: "barr"
    click_button 'Save changes'


    expect(user.reload.name).to_not eq "Dukepi"
  end


end
