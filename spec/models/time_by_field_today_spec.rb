require 'rails_helper'

RSpec.describe TimeByFieldToday, type: :model do
  require 'rails_helper'

    #let!(:user){FactoryBot.create(:user)}

    #let(:time_by_field){ user.time_by_fields.create(color:'red',count:4,field: 'ruby')}
    let(:time_by_field){ TimeByField.find_by(field:'ruby')}
    let(:time_by_field_today){ TimeByFieldToday.find_by(time_by_field_id: time_by_field)}
    before do
      FactoryBot.create(:login_user_with_studies)
    end
    #正しい値の時、初期化が行われるか
    it  "has a valid factory" do
      expect(time_by_field_today).to be_valid
    end

    describe 'relations' do
      it do
        is_expected.to belong_to(:time_by_field)
      end
    end



end
