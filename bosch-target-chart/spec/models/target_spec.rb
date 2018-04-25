require 'rails_helper'

RSpec.describe Target, type: :model do

  describe 'validations' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to belong_to(:category) }

    it { is_expected.to have_many(:indicators) }

    it { is_expected.to have_and_belong_to_many(:charts) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:department_id) }
    it { is_expected.to validate_presence_of(:category_id) }
    it { is_expected.to validate_presence_of(:unit) }
    it { is_expected.to validate_presence_of(:unit_type) }

    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_numericality_of(:year).only_integer }
    it { is_expected.to validate_numericality_of(:year).is_greater_than_or_equal_to(0) }

    it { is_expected.to validate_inclusion_of(:unit_type).in_array(Target::UNIT_TYPES) }

    describe 'compare_to_value and rule' do
      context 'new_record and is_qualitative' do
        before { allow(subject).to receive(:new_record?).and_return(true) }
        before { allow(subject).to receive(:is_numerical?).and_return(false) }
        it { is_expected.to_not validate_presence_of(:compare_to_value) }
        it { is_expected.to_not validate_presence_of(:rule) }
        it { should allow_value(nil).for(:rule) }
      end

      context 'new_record and is_numerical' do
        before { allow(subject).to receive(:new_record?).and_return(true) }
        before { allow(subject).to receive(:is_numerical?).and_return(true) }
        it { is_expected.to validate_presence_of(:compare_to_value) }
        it { is_expected.to validate_presence_of(:rule) }
        it { is_expected.to validate_inclusion_of(:rule).in_array(Target::RULES) }
      end

      context 'compare_to_value changed' do
        before { allow(subject).to receive(:compare_to_value_changed?).and_return(true) }
        it { is_expected.to validate_presence_of(:compare_to_value) }
      end

      context 'compare_to_value not changed' do
        before { allow(subject).to receive(:compare_to_value_changed?).and_return(false) }
        it { is_expected.to_not validate_presence_of(:compare_to_value) }
      end

      context 'rule changed' do
        before { allow(subject).to receive(:new_record?).and_return(false) }
        before { allow(subject).to receive(:rule_changed?).and_return(true) }
        it { is_expected.to validate_presence_of(:rule) }
        it { is_expected.to validate_inclusion_of(:rule).in_array(Target::RULES) }
      end

      context 'rule not changed' do
        before { allow(subject).to receive(:rule_changed?).and_return(false) }
        it { is_expected.to_not validate_presence_of(:rule) }
        it { should allow_value(nil).for(:rule) }
      end
    end
  end

  describe 'scopes' do
    describe 'for_year' do
      it 'should return targets for the given year' do
        tar17 = FactoryBot.create(:target, year: 2017)
        tar18 = FactoryBot.create(:target, year: 2018)
        tar19 = FactoryBot.create(:target, year: 2019)

        expect(Target.for_year(2018).to_a).to eq([tar18])
      end
    end

    describe 'with_indicators' do
      it 'should return targets with indicators' do
        tar1 = FactoryBot.create(:target)
        tar2 = FactoryBot.create(:target)
               FactoryBot.create(:indicator, target: tar2)

        expect(Target.with_indicators.to_a).to eq([tar2])
      end
    end
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

      it 'should reset rule when target is qualitative' do
        t = FactoryBot.create(:target, :numerical, rule: Target::RULES[0])
        t.update_attribute(:unit_type, Target::UNIT_TYPES[1])

        expect(t.reload.rule).to eq(nil)
      end

      it 'should set default rule when target is numerical' do
        t = FactoryBot.create(:target, :qualitative, rule: nil)
        t.update_attribute(:unit_type, Target::UNIT_TYPES[0])

        expect(t.reload.rule).to eq(Target::DEFAULT_RULE)
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
end
