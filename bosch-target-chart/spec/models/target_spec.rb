require 'rails_helper'

RSpec.describe Target, type: :model do

  describe 'validations' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to belong_to(:category) }

    it { is_expected.to have_many(:indicators) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:department_id) }
    it { is_expected.to validate_presence_of(:category_id) }
    it { is_expected.to validate_presence_of(:unit) }
    it { is_expected.to validate_presence_of(:unit_type) }

    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_numericality_of(:year).only_integer }
    it { is_expected.to validate_numericality_of(:year).is_greater_than_or_equal_to(0) }

    it { is_expected.to validate_numericality_of(:rule).only_integer }
    it { is_expected.to validate_numericality_of(:rule).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:rule).is_less_than_or_equal_to(1) }

    it { is_expected.to validate_inclusion_of(:unit_type).in_array(Target::UNIT_TYPES) }

    context 'is numerical' do
      before { allow(subject).to receive(:is_qualitative?).and_return(false) }
      it { is_expected.to validate_presence_of(:compare_to_value) }
      it { is_expected.to validate_presence_of(:rule) }
    end

    context 'is qualitative' do
      before { allow(subject).to receive(:is_qualitative?).and_return(true) }
      it { is_expected.to_not validate_presence_of(:compare_to_value) }
      it { is_expected.to_not validate_presence_of(:rule) }
    end
  end
end
