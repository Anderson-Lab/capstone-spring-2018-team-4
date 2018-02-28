require 'rails_helper'

RSpec.describe Target, type: :model do
  it { is_expected.to belong_to(:department) }
  it { is_expected.to belong_to(:category) }

  it { is_expected.to have_many(:indicators) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:department_id) }
  it { is_expected.to validate_presence_of(:category_id) }
  it { is_expected.to validate_presence_of(:unit) }
  it { is_expected.to validate_presence_of(:update_frequency) }
end
