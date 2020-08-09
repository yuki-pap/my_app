require 'rails_helper'

RSpec.describe Marker, type: :model do

  let!(:user){FactoryBot.create(:user)}
  let(:marker){user.markers.create(color: 'red', field: 'テスト', number: 1)}
  #正しい値の時、初期化が行われるか
  it  "has a valid factory" do
    expect(marker).to be_valid
  end

  describe 'relations' do
    it do
      is_expected.to belong_to(:user)
    end
  end
#バリデーションのテスト
  describe 'validations' do
    it do
      is_expected.to validate_presence_of(:color)
      is_expected.to validate_presence_of(:number)
      is_expected.to validate_length_of(:field)
          .is_at_most(20)

    end
  end
end
