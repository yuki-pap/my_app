require 'rails_helper'

describe "time-by-field", type: :request do
      let(:user){FactoryBot.create(:login_user_with_studies)}

      before do
        #ログイン
        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end


      describe "GET#index" do
          it "正しくデータが帰って来るか" do
            #todayアクションへのgetリクエスト
            get api_v1_time_by_fields_path
            expect(response).to have_http_status(200)
            json = JSON.parse(response.body)
            expect(json.length).to eq 1
            expect(json['0']['color']).to eq 'red-image'
          end
      end
end
