require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:targets) }

  it { is_expected.to validate_presence_of(:name) }

  describe 'image_name' do
    it 'should return an appropriate image name' do
      category = FactoryBot.build(:category, name: 'Cat me if you can')

      expect(category.image_name).to eq('cat_me_if_you_can')
    end
  end
end
