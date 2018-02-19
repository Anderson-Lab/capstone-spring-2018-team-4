require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a valid factory' do
    expect(build(:user)).to be_valid
  end

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to validate_uniqueness_of(:email) }

  it { is_expected.to allow_value("user@example.com").for(:email) }
  it { is_expected.to_not allow_value("user.example.com").for(:email) }
end
