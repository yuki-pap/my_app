require 'rails_helper'

RSpec.describe Graph, type: :model do
  let!(:user){FactoryBot.create(:user)}
  let(:graph){user.graphs.create(color: 'red', field: 'テスト', number: 1, fill: true)}

  before do
    FactoryBot.create(:login_user_with_studies)
  end

  #正しい値の時、初期化が行われるか
  it  "has a valid factory" do
    expect(graph).to be_valid
  end

  describe 'relations' do
    it do
      is_expected.to belong_to(:user)
    end
  end
#バリデーションのテスト
  describe 'validations' do
    it do

      is_expected.to validate_presence_of(:number)
      is_expected.to validate_length_of(:field)
          .is_at_most(20)

    end
  end
end
