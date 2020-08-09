require 'rails_helper'

RSpec.describe TimeByField, type: :model do
  let!(:user){FactoryBot.create(:user)}

  let(:time_by_field){ user.time_by_fields.create(color:'red',count:4,field: 'ruby')}
  #正しい値の時、初期化が行われるか
  it  "has a valid factory" do
    expect(time_by_field).to be_valid
  end

  describe 'relations' do
    it do
      is_expected.to belong_to(:user)
    end
  end

end
