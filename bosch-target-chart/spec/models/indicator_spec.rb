require 'rails_helper'

RSpec.describe Indicator, type: :model do
  it { is_expected.to belong_to(:target) }
end
