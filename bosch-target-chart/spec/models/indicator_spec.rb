require 'rails_helper'

RSpec.describe Indicator, type: :model do
  it { is_expected.to belong_to(:target) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:value) }
end
