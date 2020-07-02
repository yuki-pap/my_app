require 'rails_helper'


describe "Studies", type: :request do

  let(:study){User.find_by(email: "test@example.com").studies.find_by(date: Time.current.strftime("%Y年%m月%d日"))}
  let(:month){User.find_by(email: "test@example.com").months.find_by(month: Time.current.strftime("%Y年%m月"))}
  before do
   FactoryBot.create(:login_user_with_studies).studies
  end

    describe "GET /studies/new" do

      context "as login_user" do

        it "returns http success with valid user" do
          #ログイン
          post login_path, params: { session: { email: "test@example.com",
                                          password: "foobar",
                                          remember_me: '1'}}

          get new_study_path
          expect(response).to redirect_to study_path(study)
          expect(response).to have_http_status "302"
        end
      end

      context "as a guest" do
        it "redirect login_path" do
          get new_study_path

          expect(response).to redirect_to login_path
        end
      end
    end


    describe "#create" do
      context "as login_user" do
        it "redirect study_show "  do
          #ログイン
          post login_path, params: { session: { email: "test@example.com",
                                        password: "foobar",
                                        remember_me: '1'}}
          post studies_path

          expect(response).to redirect_to  study_path(study)
        end
      end

      context "as a guest" do
        it "redirect login_path" do
          post studies_path
          expect(response).to redirect_to login_path
        end
      end

    end

    describe "#show" do
      context "as login_user" do
        it "returns http success with valid user"do
          post login_path, params: { session: { email: "test@example.com",
                                      password: "foobar",
                                      remember_me: '1'}}
          get study_path(study)
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end

      context "as a guest" do
        it "redirect login_path"do
          get study_path(study)
          expect(response).to redirect_to login_path
        end
      end
    end

    describe "#update" do
      context "as login_user" do
        it "returns http success with valid user"do
          post login_path, params: { session: { email: "test@example.com",
                                      password: "foobar",
                                      remember_me: '1'}}
          patch study_path(study), params: { study:{ time_count: 45}}

          expect(study.reload.count).to eq 8
          expect(month.reload.time_count).to eq 13

        end
      end

      context "as a guest" do
        it "redirect login_path"do
          patch study_path(study), params: { study:{ time_count: 3 }}
          expect(response).to redirect_to login_path
        end
      end



    end
end
