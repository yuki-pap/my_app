require 'rails_helper'


describe "histories", type: :request do

  let(:user){FactoryBot.create(:user)}

      before do
        # historymodelをDBに登録
        user.histories.create(image_data_uri: "data:image/png;base64,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",
         number:1,
         percent:100)
        #ログイン
        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end

    describe "GET /history#index" do

        it "レスポンスを正しく返すか" do

          get api_v1_histories_path
          expect(response).to have_http_status(200)
          json = JSON.parse(response.body)
          expect(json.length).to eq 1
          

        end


     end


end