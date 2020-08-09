require 'rails_helper'

describe "time-by-field-today", type: :request do
      let(:user){FactoryBot.create(:login_user_with_studies)}

      before do
        #ログイン
        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end


      describe "GET#index" do
          it "正しくデータが帰って来るか" do

            get api_v1_time_by_field_todays_path,params: {id: user.id}
            expect(response).to have_http_status(200)
            json = JSON.parse(response.body)
            expect(json.length).to eq 1
            expect(json['0']['count']).to eq "1時間15分"
          end
      end
end
