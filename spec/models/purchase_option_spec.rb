# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchaseOption, type: :model do
  it 'should be created' do
    expect(create(:purchase_option).id).to be > 0
  end

  it 'validates quality' do
    expect(build(:purchase_option, quality: 'invalid').valid?).to be false
  end

  it 'asserts HD and SD as valid quality' do
    expect(build(:purchase_option, quality: 'HD').valid?).to be true
    expect(build(:purchase_option, quality: 'SD').valid?).to be true
  end

  it 'validates price' do
    expect(build(:purchase_option, price: -1).valid?).to be false
  end
end
