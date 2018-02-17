require 'rails_helper'

RSpec.describe Department, type: :model do
  it { is_expected.to have_many(:targets) }
end
