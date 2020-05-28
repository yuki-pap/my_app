require 'rails_helper'

describe "Sessions", type: :request do

  describe "#new" do
    it "returns http success" do
      get signup_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "#show" do
    it "returns http success" do
      
    end

  end


end
