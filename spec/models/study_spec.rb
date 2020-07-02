require 'rails_helper'

RSpec.describe Study, type: :model do

  let!(:user){FactoryBot.create(:user)}
  let!(:study){FactoryBot.create(:study)}
  #正しい値の時、初期化が行われるか
  it  "has a valid factory" do
    expect(study).to be_valid
  end


  describe 'relations' do
    it do
      is_expected.to belong_to(:user)
    end
  end
#バリデーションのテスト
  describe 'validations' do
    it do
      is_expected.to validate_presence_of(:user_id)
      is_expected.to validate_presence_of(:count)
      is_expected.to validate_presence_of(:date)
      is_expected.to validate_numericality_of(:count)
         .is_greater_than(-1)
      is_expected.to validate_numericality_of(:count)
          .is_less_than(97)
      is_expected.to validate_numericality_of(:count)
          .only_integer
      is_expected.to validate_uniqueness_of(:user_id).scoped_to(:date)
      is_expected.to validate_length_of(:content_today)
          .is_at_most(140)

    end


  end
#インスタンスメソッドのテスト
  describe 'instance_method' do
    it "returns a correct value" do
      expect(study.count_time).to eq "1時間15分"
    end

  end

end
