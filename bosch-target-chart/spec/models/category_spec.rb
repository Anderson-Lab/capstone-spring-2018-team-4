require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:targets) }
  it { should have_attached_file(:icon) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:color) }

  it { is_expected.to validate_inclusion_of(:color).in_array(Category::COLOR_HEX_VALUES_HASH.values) }

  it { is_expected.to validate_presence_of(:icon) }
  it { should validate_attachment_content_type(:icon).
                allowing('image/jpeg', 'image/jpg', 'image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }
end
