require 'rails_helper'

describe "markers", type: :request do
      let(:user){FactoryBot.create(:login_user_with_studies)}

      before do
        #ログイン
        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end

      describe "GET#edit" do
          it "正しくデータが帰って来るか" do
            #todayアクションへのgetリクエスト
            get edit_marker_path(1)
            expect(response).to have_http_status(200)

          end
      end


  end
