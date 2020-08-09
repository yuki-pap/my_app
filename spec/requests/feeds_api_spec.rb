require 'rails_helper'

describe "feeds", type: :request do

      let(:user){ FactoryBot.create(:user) }
      let(:other_user){ FactoryBot.create(:user,name: "essei") }

      before do
        #ログイン
        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end

    describe "GET /feeds#index" do

        it "APIが正しく動くか" do
          #誰もフォローしていない時
          get api_v1_feeds_path
          expect(response).to have_http_status(200)
          json = JSON.parse(response.body)
          expect(json.length).to eq 0
          #フォローしてる人がいる時
          Relationship.create(follower_id: user.id,
                                followed_id: other_user.id)

          get api_v1_feeds_path
          expect(response).to have_http_status(200)
          json = JSON.parse(response.body)
          expect(json.length).to eq 1
        end
    end


end
