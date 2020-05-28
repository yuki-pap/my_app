require 'rails_helper'

describe "User pages", type: :request do

  describe "GET #new" do
    it "returns http success" do
      get signup_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do

  end


end
