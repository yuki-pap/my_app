require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user){FactoryBot.create(:user, name: "naoya")}
  let(:another_user){FactoryBot.create(:user,name: "essei")}

  let(:relationship){Relationship.new(follower_id: user.id,
                        followed_id: another_user.id)}
    #正しい値での初期化が有効か
    it "has a valid factory" do
       expect(relationship).to be_valid
    end
    #バリデーションのテスト
    describe "valiodations" do

      it do
        is_expected.to validate_presence_of(:followed_id)

        is_expected.to validate_presence_of(:follower_id)
      end

    end

end
