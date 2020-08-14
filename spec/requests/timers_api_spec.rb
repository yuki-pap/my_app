require 'rails_helper'

describe "timers", type: :request do
      let(:user){FactoryBot.create(:login_user_with_studies)}

      before do
        200.times do |n|
          user.graphs.create(color:'white',fill: false,number:n)
        end
        #ログイン
        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end

      describe "create" do
        it "塗り絵のアップデートができるか" do

          expect {
            post api_v1_timers_path, params: {timer:{count: 2,color:'red'}}
          }.to change(user.graphs.where(fill:true), :count).by(0)
          expect(response).to have_http_status(:success)


        end
      end

      describe "GET#index" do
          it "正しくデータが帰って来るか" do
            #todayアクションへのgetリクエスト
            get api_v1_timers_path
            expect(response).to have_http_status(200)
            json = JSON.parse(response.body)
            expect(json.length).to eq 3
          end
      end
end
