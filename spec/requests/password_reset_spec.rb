require 'rails_helper'

describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user)}
  it "resets password" do
    #createアクションメールアドレス無効
    post password_resets_path, params: { password_reset: { email: ""}}
    expect(response).to render_template(:new)
    #createアクションメールアドレス有効
    post password_resets_path, params: { password_reset: { email: user.email}}
    expect(response).to redirect_to root_url
    #コントローラのインスタンス変数取得
    user = assigns(:user)
    #editアクションへのメールアドレスが無効
    get edit_password_reset_path(user.reset_token,email: "")
    expect(response).to redirect_to root_url

    #editアクションへのメールアドレスが有効でトークンが無効
    get edit_password_reset_path('wrong_token',email: user.email)
    expect(response).to redirect_to root_url
    #editアクションへのメールアドレスもトークンも有効
    get edit_password_reset_path(user.reset_token,email: user.email)
    expect(response).to render_template(:edit)
    #updateアクションへのパスワードが無効
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
                  user:{ password: "foovaz",
                         password_confirmation: "barquux"}}
    expect(response).to render_template(:edit)
    #updateアクションへのパスワードが空
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
                  user:{ password: "",
                         password_confirmation: ""}}
    expect(response).to render_template(:edit)
    #updateアクションへのパスワードが有効
    patch password_reset_path(user.reset_token),
        params: { email: user.email,
                  user:{ password: "foovaz",
                         password_confirmation: "foovaz"}}

    expect(session[:user_id]).to eq user.id
    expect(response).to redirect_to user_path(user)
  end
end
