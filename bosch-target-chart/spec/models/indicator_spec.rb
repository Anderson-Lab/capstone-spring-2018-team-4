require 'rails_helper'

RSpec.describe Indicator, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:target) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    context 'target is numerical' do
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

  describe 'instance methods' do
    describe 'is_positive?' do
      context 'target is numerical' do
        it 'should compare the difference using the target rule' do
          target      = FactoryBot.create(:target, :numerical, compare_to_value: 25, rule: Target::RULES[0])
          indicator_1 = FactoryBot.create(:indicator, target: target, value: 20)
          indicator_2 = FactoryBot.create(:indicator, target: target, value: 30)

          expect(indicator_1.is_positive?).to eq(false)
          expect(indicator_2.is_positive?).to eq(true)
        end
      end

      context 'target is qualitative' do
        it "should return true if the color is #{Indicator::COLORS[0]}" do
          target    = FactoryBot.create(:target)
          indicator = FactoryBot.create(:indicator, target: target, color: Indicator::COLORS[0])

          expect(indicator.is_positive?).to eq(true)
        end

        it "should return false if the color is not #{Indicator::COLORS[0]}" do
          target    = FactoryBot.create(:target)
          indicator = FactoryBot.create(:indicator, target: target, color: Indicator::COLORS[1])

          expect(indicator.is_positive?).to eq(false)
        end
      end
    end

    describe 'is_neutral?' do
      context 'target is numerical' do
        it 'should return false' do
          target      = FactoryBot.create(:target, :numerical, compare_to_value: 25, rule: Target::RULES[0])
          indicator_1 = FactoryBot.create(:indicator, target: target, value: 20)
          indicator_2 = FactoryBot.create(:indicator, target: target, value: 30)
          indicator_3 = FactoryBot.create(:indicator, target: target, value: 25)

          expect(indicator_1.is_neutral?).to eq(false)
          expect(indicator_2.is_neutral?).to eq(false)
          expect(indicator_3.is_neutral?).to eq(false)
        end
      end

      context 'target is qualitative' do
        it "should return true if the color is #{Indicator::COLORS[1]}" do
          target    = FactoryBot.create(:target)
          indicator = FactoryBot.create(:indicator, target: target, color: Indicator::COLORS[1])

          expect(indicator.is_neutral?).to eq(true)
        end

        it "should return false if the color is not #{Indicator::COLORS[1]}" do
          target    = FactoryBot.create(:target)
          indicator = FactoryBot.create(:indicator, target: target, color: Indicator::COLORS[2])

          expect(indicator.is_neutral?).to eq(false)
        end
      end
    end

    describe 'is_negative?' do
      context 'target is numerical' do
        it 'should compare the difference using the target rule' do
          target      = FactoryBot.create(:target, :numerical, compare_to_value: 25, rule: Target::RULES[0])
          indicator_1 = FactoryBot.create(:indicator, target: target, value: 20)
          indicator_2 = FactoryBot.create(:indicator, target: target, value: 30)

          expect(indicator_1.is_negative?).to eq(true)
          expect(indicator_2.is_negative?).to eq(false)
        end
      end

      context 'target is qualitative' do
        it "should return true if the color is #{Indicator::COLORS[2]}" do
          target    = FactoryBot.create(:target)
          indicator = FactoryBot.create(:indicator, target: target, color: Indicator::COLORS[2])

          expect(indicator.is_negative?).to eq(true)
        end

        it "should return false if the color is not #{Indicator::COLORS[2]}" do
          target    = FactoryBot.create(:target)
          indicator = FactoryBot.create(:indicator, target: target, color: Indicator::COLORS[1])

          expect(indicator.is_negative?).to eq(false)
        end
      end
    end

    describe 'difference' do
      context 'value is not nil' do
        it 'should return the difference of the compare_to_value and value' do
          target    = FactoryBot.create(:target, :numerical, compare_to_value: 25)
          indicator = FactoryBot.create(:indicator, target: target, value: 20)
          
          expect(indicator.difference).to eq(5)
        end
      end

      context 'value is nil' do
        it 'should return the difference of the compare_to_value and value=0' do
          target    = FactoryBot.create(:target, :numerical, compare_to_value: 25)
          indicator = FactoryBot.create(:indicator, target: target)
          indicator.value = nil
          
          expect(indicator.difference).to eq(25)
        end
      end
    end
  end
end
