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

    it { is_expected.to validate_inclusion_of(:unit_type).in_array(Target::UNIT_TYPES) }
  end

  describe 'callbacks' do
    describe '#reset_compare_to_value' do
      it 'should be called when unit_type is changed' do
        t = FactoryBot.create(:target)
        expect(t).to receive(:reset_indicator_values)
        t.update_attribute(:unit_type, Target::UNIT_TYPES[Target::UNIT_TYPES.index(t.unit_type) + 1 % 2])
      end

      it 'should reset compare_to_value when target is qualitative' do
        t = FactoryBot.create(:target, :numerical, compare_to_value: 100.0)
        t.update_attribute(:unit_type, Target::UNIT_TYPES[1])

        expect(t.reload.compare_to_value).to eq(nil)
      end
    end

    describe '#reset_indicator_values' do
      it 'should be called when unit_type changed' do
        t = FactoryBot.create(:target)
        expect(t).to receive(:reset_indicator_values)
        t.update_attribute(:unit_type, Target::UNIT_TYPES[Target::UNIT_TYPES.index(t.unit_type) + 1 % 2])
      end

      context 'target is numerical' do
        it 'should reset color and value on indicators' do
          t = FactoryBot.create(:target)
          i = FactoryBot.create(:indicator, target: t, value: nil, color: 'Green')
          t.update_attribute(:unit_type, Target::UNIT_TYPES[0])

          expect(i.reload.value).to eq(nil)
          expect(i.reload.color).to eq(nil)
        end
      end

      context 'target is qualitative' do
        it 'should reset value' do
          t = FactoryBot.create(:target, :numerical)
          i = FactoryBot.create(:indicator, target: t, value: 100)
          t.update_attribute(:unit_type, Target::UNIT_TYPES[1])

          expect(i.reload.value).to eq(nil)
        end
      end
    end
  end

  describe 'instance methods' do
    context 'is numerical' do
      before { allow(subject).to receive(:is_qualitative?).and_return(false) }
      it { is_expected.to validate_presence_of(:compare_to_value) }
      it { is_expected.to validate_presence_of(:rule) }
      it { is_expected.to validate_inclusion_of(:rule).in_array(Target::RULES) }
    end

    context 'is qualitative' do
      before { allow(subject).to receive(:is_qualitative?).and_return(true) }
      it { is_expected.to_not validate_presence_of(:compare_to_value) }
      it { is_expected.to_not validate_presence_of(:rule) }
      it { should allow_value(nil).for(:rule) }
    end

    context 'changed from qualitative to numerical' do
      before { allow(subject).to receive(:unit_type_changed?).and_return(true) }
      it { is_expected.to_not validate_presence_of(:compare_to_value) }
      it { is_expected.to_not validate_presence_of(:rule) }
      it { should allow_value(nil).for(:rule) }
    end
  end
end
