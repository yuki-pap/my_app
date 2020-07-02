require 'rails_helper'

describe "Relationships", type: :request do
  let!(:user){FactoryBot.create(:user, name: "naoya",email: "test6000@example.com")}
  let!(:another_user){FactoryBot.create(:user,name: "essei")}
  let!(:other_user){FactoryBot.create(:user, name: "take")}

  let!(:relationship){Relationship.create(follower_id: user.id,
                        followed_id: another_user.id)}

  describe "#create" do
    context "as a guest" do
      it "redirect_to login_path" do
          expect{
            post relationships_path
          }.to change(Relationship, :count).by(0)

          expect(response).to redirect_to login_path
      end
    end
    context "as a login_user" do
      it "is able to follow a user " do
        post login_path, params: { session: { email: "test6000@example.com",
                                      password: "foobar",
                                      remember_me: '1'}}

        expect{
            post relationships_path, params: {followed_id: other_user.id}
          }.to change(Relationship, :count).by(1)


      end
    end
  end

  describe "destroy" do
    context "as a guest" do
      it "redirect_to login_path" do
        delete relationship_path(user.active_relationships.find_by(followed_id: another_user.id ))
        expect(response).to redirect_to login_path
      end
    end
    context "as a login_user" do
      it "is able to unfollow" do
           post login_path, params: { session: { email: "test6000@example.com",
                                       password: "foobar",
                                       remember_me: '1'}}
      expect{
        delete relationship_path(user.active_relationships.find_by(followed_id: another_user.id )),

        params: { followed_id: another_user.id}

      }.to change(Relationship, :count).by(-1)

      end

    end
  end


end
