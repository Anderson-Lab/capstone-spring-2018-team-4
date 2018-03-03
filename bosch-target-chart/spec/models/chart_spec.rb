require 'rails_helper'

RSpec.describe Chart, type: :model do
  it { is_expected.to have_and_belong_to_many(:targets) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_numericality_of(:year).only_integer }
  it { is_expected.to validate_numericality_of(:year).is_greater_than_or_equal_to(0) }
end
