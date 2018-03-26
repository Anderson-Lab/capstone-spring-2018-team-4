require 'rails_helper'

RSpec.describe Indicator, type: :model do
  it { is_expected.to belong_to(:target) }

  it { is_expected.to validate_presence_of(:name) }

  context 'target us numerical' do
    before { allow(subject).to receive(:target).and_return(FactoryBot.create(:target, :numerical)) }

    it { is_expected.to validate_presence_of(:value) }

    it { is_expected.to validate_numericality_of(:value) }

    it { is_expected.to_not validate_presence_of(:color) }

    it { is_expected.to_not validate_inclusion_of(:color).in_array(Indicator::COLORS) }
  end

  # By default, indicators are Qualitative
  context 'target is qualitative' do
    before { allow(subject).to receive(:target).and_return(FactoryBot.create(:target)) }

    it { is_expected.to validate_presence_of(:color) }

    it { is_expected.to validate_inclusion_of(:color).in_array(Indicator::COLORS) }

    it { is_expected.to_not validate_presence_of(:value) }

    it { is_expected.to_not validate_numericality_of(:value) }
  end
end
