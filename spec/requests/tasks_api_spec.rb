require 'rails_helper'

describe "charts", type: :request do
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
            get api_v1_tasks_path
            expect(response).to have_http_status(200)
            json = JSON.parse(response.body)
            expect(json.length).to eq 2
          end
      end

      describe "create update destroy" do
        it "モデルの作成、更新、削除ができるか" do
          #作成
          expect {
            post api_v1_tasks_path
          }.to change(Task, :count).by(1)
          expect(response).to have_http_status(:success)
          #更新
          get api_v1_tasks_path
          json = JSON.parse(response.body)
          put api_v1_task_path(json['2']['id']), params:{ task:{content:"タスク1"}}
          json = JSON.parse(response.body)
          expect(json['2']['content']).to eq 'タスク1'
          #削除
          expect {
          delete api_v1_task_path(json['2']['id'])
          }.to change(Task, :count).by(-1)

        end
      end
  end
