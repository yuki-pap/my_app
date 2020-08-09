require 'rails_helper'

describe "charts", type: :request do
      let(:user){  FactoryBot.create(:login_user_with_studies)}
      before do
        #ログイン

        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end

      describe "GET" do
          it "正しくデータが帰って来るか" do
            #todayアクションへのgetリクエスト
            get api_v1_charts_day_path
            expect(response).to have_http_status(200)
            json = JSON.parse(response.body)
            expect(json.length).to eq 30
            expect(json['1']).to eq 0
            expect(json['30']['time']).to eq "1.25"
            #monthアクションへのgetリクエスト

            get api_v1_charts_month_path
            expect(response).to have_http_status(200)
            json = JSON.parse(response.body)
            expect(json.length).to eq 12
            expect(json['1']).to eq 0
            expect(json['12']).to eq '2.5'
          end
      end
  end
