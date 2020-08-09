require 'rails_helper'

describe "graphs", type: :request do
      let(:user){ FactoryBot.create(:login_user_with_studies)}

      before do
        #ログイン
        200.times do |n|
          user.graphs.create(color:'white',fill: false,number:  n + 1)
        end

        post login_path, params: {session: { email: user.email,
                                      password: user.password,
                                       remember_me: '0'}}
      end

      describe "GET ,POST" do
        it "正しくデータが帰って来るか" do
          #getリクエスト

          get api_v1_graphs_path
          expect(response).to have_http_status(200)
          json = JSON.parse(response.body)
          expect(json.length).to eq 209
          expect(json['today']).to eq "1時間15分"
          expect(json['1']['color']).to eq 'white'
          expect(json['200']['color']).to eq 'white'

          #postリクエスト
          post api_v1_graphs_path, params: {graph: { id:1,
                                                     color:'red'}}
          json = JSON.parse(response.body)
          expect(json['1']['color']).to eq 'red'
          post api_v1_graphs_path, params:{graph:{id: 1,col:'red'}}
          json = JSON.parse(response.body)
          expect(json['1']['color']).to eq 'white'
        end
      end
  end


#getとpostを分けると後に実行する方で作成したデータが見つからない、dbcleanerが原因？
