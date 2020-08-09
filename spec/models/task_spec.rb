require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user){FactoryBot.create(:user)}
  let!(:study){FactoryBot.create(:study)}
  let(:task){ FactoryBot.create(:task)}
  #正しい値の時、初期化が行われるか
  it  "has a valid factory" do
    expect(task).to be_valid
  end

  describe 'relations' do
    it do
      is_expected.to belong_to(:study)
    end
  end
#バリデーションのテスト
  describe 'validations' do
    it do
      is_expected.to validate_length_of(:content)
          .is_at_most(40)
    end
  end
end
